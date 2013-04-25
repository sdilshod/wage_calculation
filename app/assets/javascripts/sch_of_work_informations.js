/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/*/

$(function() {
 var arr = $('table input[data-calendar]')
 $.each(arr, function(index, item){
     $(item).datepicker({  
        dateFormat: "yy-mm-dd" ,
        nextText: ">>",
        prevText: "<<",
        buttonText: "",
        showOn: "button",
        buttonImage: "/assets/calendar.png",
        buttonImageOnly: true,
        showOtherMonths: true, 
        dayNamesMin: ['Sun', 'M65on', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],  

        })  
     $(item).parent().find('img').hide();
 });
});


