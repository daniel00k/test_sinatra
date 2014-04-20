TwitterApp.Router.map(function() {
  this.resource("followers", {
    path: '/followers'
  });
  this.resource("favorites", {
    path: '/favorites'
  });
});
