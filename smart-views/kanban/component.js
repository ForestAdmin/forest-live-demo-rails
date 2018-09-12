'use strict';
import Ember from 'ember';
import SmartViewMixin from 'client/mixins/smart-view-mixin';

export default Ember.Component.extend(SmartViewMixin.default, {
  classNames: ['kanban-container'],
  router: Ember.inject.service('-routing'),
  store: Ember.inject.service(),
  relationshipUpdater: Ember.inject.service('relationship-updater'),
  loaded: false,
  kanbanId: null,
  kanban: null,
  boards: [],
  loadPlugin: function () {
    Ember.run.scheduleOnce('afterRender', this, () => {
      this.set('kanbanId', `${this.get('element.id')}-kanban`);
      this.set('Treatment', this.get('store').peekAll('collection').findBy('name', 'Treatment'));

      Ember.$.getScript('//cdn.rawgit.com/SeyZ/jkanban/8cb7f795/dist/jkanban.js', () => {
        this.set('loaded', true);

        var boards = [];

        this.get('records').forEach((record) => {
          boards.push({
            id: record.get('id'),
            title: record.get('forest-name'),
            item: []
          });

          record.reload().then((record) => {
            record.query('forest-customers', {
              page: { size: 100, number: 1 }
            })
            .then((customers) => {
              customers.forEach((customer) => {
                this.get('kanban').addElement(record.get('id'), {
                  id: customer.get('id'),
                  title: `${customer.get('forest-firstname')} ${customer.get('forest-lastname')}`,
                  click: () => {
                    customer.reload().then((customer) => {
                      if (customer.get('forest-treatment.id')) {
                        this.get('router').transitionTo('rendering.data.collection.list.viewEdit.summary',
                          [this.get('Treatment.id'), customer.get('forest-treatment.id')]);
                      }
                    });
                  }
                });
              });
            });
          });
        });

        this.set('kanban', new jKanban({
          element: `#${this.get('kanbanId')}`,
          gutter: '10px',
          widthBoard: '450px',
          boards: boards,
          dragBoards: false,
          dropEl: (el, target, source, sibling) => {
            return this.get('store')
              .find('forest-Customer', el.dataset.eid)
              .then((customer) => {
                const newStatusId = `${$(target.parentElement).data('id')}`;
                const newStatus = this.get('records').findBy('id', newStatusId);
                customer.set('forest-patient_status', newStatus);

                const environment = this.get('collection.rendering.environment');

                this.get('relationshipUpdater')
                  .updateBelongsTo(environment, 'Customer', customer, 'forest-patient_status', newStatus);
              });
          }
        }));

        $('.kanban-board').css('max-height', $('.collectionList__content').height() - 50);
        $('.kanban-board').css('overflow', 'auto');
      });

      var cssLink = $('<link>');
      $('head').append(cssLink);

      cssLink.attr({
        rel:  'stylesheet',
        type: 'text/css',
        href: '//cdn.rawgit.com/riktar/jkanban/f2a39a79/dist/jkanban.css'
      });
    });
  }.on('init')
});
