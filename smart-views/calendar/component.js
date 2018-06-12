'use strict';
import Ember from 'ember';
import SmartViewMixin from 'client/mixins/smart-view-mixin';

export default Ember.Component.extend(SmartViewMixin.default, {
  router: Ember.inject.service('-routing'),
  store: Ember.inject.service(),
  conditionAfter: null,
  conditionBefore: null,
  loaded: false,
  calendarId: null,
  loadPlugin: function() {
    var that = this;
    Ember.run.scheduleOnce('afterRender', this, function () {
      if (this.get('viewList.recordPerPage') !== 50) {
        this.set('viewList.recordPerPage', 50);
        this.sendAction('updateRecordPerPage');
      }

      that.set('calendarId', `${this.get('element.id')}-calendar`);
      Ember.$.getScript('//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.js', function () {
        that.set('loaded', true);

        $(`#${that.get('calendarId')}`).fullCalendar({
          allDaySlot: false,
          minTime: '00:00:00',
          defaultDate: new Date(2018, 2, 1),
          eventClick: function (event, jsEvent, view) {
            that.get('router')
              .transitionTo('rendering.data.collection.list.viewEdit.details',
                [that.get('collection.id'), event.id]);
          },
          viewRender: function(view, element) {
            const field = that.get('collection.fields').findBy('field', 'start_date');

            if (that.get('conditionAfter')) {
              that.sendAction('removeCondition', that.get('conditionAfter'), true);
              that.get('conditionAfter').destroyRecord();
            }
            if (that.get('conditionBefore')) {
              that.sendAction('removeCondition', that.get('conditionBefore'), true);
              that.get('conditionBefore').destroyRecord();
            }

            const conditionAfter = that.get('store').createRecord('condition');
            conditionAfter.set('field', field);
            conditionAfter.set('operator', 'is after');
            conditionAfter.set('value', view.start);
            conditionAfter.set('smartView', that.get('viewList'));
            that.set('conditionAfter', conditionAfter);

            const conditionBefore = that.get('store').createRecord('condition');
            conditionBefore.set('field', field);
            conditionBefore.set('operator', 'is before');
            conditionBefore.set('value', view.end);
            conditionBefore.set('smartView', that.get('viewList'));
            that.set('conditionBefore', conditionBefore);

            that.sendAction('addCondition', conditionAfter, true);
            that.sendAction('addCondition', conditionBefore, true);

            that.sendAction('fetchRecords', { page: 1 });
          }
        });
      });

      var cssLink = $('<link>');
      $('head').append(cssLink);

      cssLink.attr({
        rel:  'stylesheet',
        type: 'text/css',
        href: '//cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.1.0/fullcalendar.min.css'
      });
    });
  }.on('init'),
  setEvent: function () {
    if (!this.get('records')) { return; }

    var events = [];
    var calendar = $(`#${this.get('calendarId')}`);
    calendar.fullCalendar('removeEvents');

    this.get('records').forEach(function (appointment) {
      var event = {
          id: appointment.get('id'),
          title: appointment.get('forest-name'),
          start: appointment.get('forest-start_date'),
          end: appointment.get('forest-end_date')
      };

      calendar.fullCalendar('renderEvent', event, true);
    });
  }.observes('loaded', 'records.[]')
});
