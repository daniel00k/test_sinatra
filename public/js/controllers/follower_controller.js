TwitterApp.FollowerShowController = Ember.ArrayController.extend({
  actions: {
    update: function(param) {
      param.save();
      return this.transitionToRoute('index');
    }
  }
});
