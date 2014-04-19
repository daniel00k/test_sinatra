var showForm=function(){
   $("#topics_form").show();
}
var validateForm = function(){
   if ($("#topics_input").val().split(",").length != 5) {
      $("#insert_words").addClass("error");
      $("#error_words").show();
      return false;
   }
}
$(document).ready(function(){
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