// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
 var btn_submit_value="";

function check_nested_attr_destroy(obj) {
     
    el_parent = $(obj).parent();
    el_hidden = el_parent.find('input');
    id_of_el_hidden = el_hidden.attr('id');
    
    if(id_of_el_hidden = /exist/)
    {
        el_hidden.val(1);
        $(obj).parent().parent().hide();
    }else
    {
        $(obj).parent().parent().remove();
    }
    
}

/* Setting event listener for ajax callbacks */
$.ajaxPrefilter(function(options,originalOptions,jqXHR){
    
    if (!$('#ajax_loader').is(":visible"))
    {
        $('#ajax_loader').show();
        var bt_obj = $('form[data-remote] input[type=submit]');
        btn_submit_value = bt_obj.val();
        bt_obj.val("Ждите..");
        bt_obj.attr("disabled", "disabled");
    }
    
})

$('head').ajaxComplete(function(event, request,setting) {
    $('#ajax_loader').hide();
    var bt_obj = $('form[data-remote] input[type=submit]');
    bt_obj.val(btn_submit_value);
    btn_submit_value="";
    bt_obj.removeAttr("disabled");
})

/*---*/
