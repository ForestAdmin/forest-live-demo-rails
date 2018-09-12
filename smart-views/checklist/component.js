'use strict';
import Ember from 'ember';
import SmartViewMixin from 'client/mixins/smart-view-mixin';

export default Ember.Component.extend(SmartViewMixin.default, {
  updateValue: (record) => {
    record.toggleProperty('forest-is_done');
    record.save();
  },
});
