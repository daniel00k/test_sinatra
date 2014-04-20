window.TwitterApp = Ember.Application.create({rootElement: "#container"});
var showForm=function(){
   $("#topics_form").show();
}

var transitionTo=function(routeName){
  TwitterApp.Router.router.transitionTo(routeName);
}
var validateForm = function(){
   if ($("#topics_input").val().split(",").length != 5) {
      $("#insert_words").addClass("error");
      $("#error_words").show();
      return false;
   }
}
$(document).on("mouseenter", ".followers-container li img", function(){
    $("#hovering").text("("+$(this).attr("alt")+")");
});

$(document).on("mouseleave",".followers-container li img", function(){
  $("#hovering").text("");
});
$(document).on("mouseenter", ".favorites-box .favorites-container img", function(){
    $("#hovering").text("("+$(this).attr("alt")+")");
});

$(document).on("mouseleave",".favorites-box .favorites-container img", function(){
  $("#hovering").text("");
});

$(document).ready(function(){
   $(document).foundation();
   $("#topics_input").tokenfield({
     allowDuplicates: false,
     minLength: 2,
     limit: 5,
     autocomplete: {
       delay: 100
     },
     showAutocompleteOnFocus: false
   });
});