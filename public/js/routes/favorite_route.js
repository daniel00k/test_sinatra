TwitterApp.FavoritesRoute = Ember.Route.extend({
  model: function() {
    return $.getJSON("/favorites").then(function(favorites){
      return favorites.map(function(favorite){return favorite;})
    });
  }
});
