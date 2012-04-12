// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

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
