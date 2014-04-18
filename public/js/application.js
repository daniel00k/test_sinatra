var showForm=function(){
   $("#topics_form").show();
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