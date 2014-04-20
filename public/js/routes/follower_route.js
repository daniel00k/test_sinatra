TwitterApp.FollowersRoute = Ember.Route.extend({
  model: function() {
    return $.getJSON("/followers").then(function(followers){
      return followers.map(function(follower){return follower;})
    });
  }
});