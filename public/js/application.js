/******************************************************************************
* Create the ember app
*
******************************************************************************/
window.TwitterApp = Ember.Application.create({rootElement: "#container"});

/******************************************************************************
* Shows the hidden form
*
******************************************************************************/
var showForm=function(){
   $("#topics_form").show();
}

/******************************************************************************
* Makes transition to a new ember route
*
******************************************************************************/
var transitionTo=function(routeName){
  TwitterApp.Router.router.transitionTo(routeName);
}

/******************************************************************************
* Checks if the data inserted in the form is valid
*
******************************************************************************/
var validateForm = function(){
   if ($("#topics_input").val().split(",").length != 5) {
      $("#insert_words").addClass("error");
      $("#error_words").show();
      return false;
   }else{
    $("#submit_button").attr("disabled", true);
   }
}

/******************************************************************************
* Adds a  hover effect to the images in the followers and favorites container
*
******************************************************************************/
$(document).on("mouseenter", ".followers-container li img", function(){
    $("#hovering").text("("+$(this).attr("alt")+")");
});

$(document).on("mouseleave",".followers-container li img", function(){
  $("#hovering").text("");
});
$(document).on("mouseenter", ".favorites-box .favorites-container", function(){
    $("#hovering").text("("+$(this).find("img").attr("alt")+")");
});

$(document).on("mouseleave",".favorites-box .favorites-container", function(){
  $("#hovering").text("");
});

$(document).ready(function(){
    /**************************************************************************
    * Starts foundation js
    *
    **************************************************************************/
   $(document).foundation();

   /**************************************************************************
    * All the alerts will be automatically removed after 3 seconds
    *
    **************************************************************************/
    setTimeout(function() {
        $(".alert-box").remove();
    }, 3000);

    /**************************************************************************
    * Activate token field plugin
    *
    **************************************************************************/
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