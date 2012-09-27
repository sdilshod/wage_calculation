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

/*   $(document).ready(function() {
      /* Activating Best In Place */
      /*jQuery(".best_in_place").best_in_place();
    }); */

/*if (rails.fire(element, 'ajax:before')) {
    if (element.is('form')) {
    } else {
        method = element.data('method');
        url = element.attr('href');
        data = element.data('params') || null;
    }
}*/




/*---*/

function AddElementsToPage(elements) {
    /*elements - is array with name elements whose will be add to page*/    
    this.add_row_to_data_table = function(obj,attributes,selector_table,save_btn, delete_btn){
        rows_of_table = selector_table.find('tbody tr');
        row_number=rows_of_table.length;
        if (row_number == 0)
        {
            row_number=1;
        }else
        {
            row_number++;
        }
        
        var new_row = "<tr><th scope='row'>"+row_number+"</th>";

        $.each(attributes, function(index, item){
            input_tag = "<input id=\""+obj+"_"+item+"\" name=\""+obj+"["+item+"]\" size=\"10\"  type=\"text\" value=\"\" />";
            new_row = new_row + "<td>"+input_tag+"</td>";
        })
        new_row = new_row + "<td>"+save_btn+"</td>"
        new_row = new_row + "<td>"+delete_btn+"</td></tr>"
        selector_table.append(new_row);
        return new_row;
    }
    
    this.get_current_row_of_data_table = function(tr_obj) {
       return $("<tr>"+tr_obj.text()+"</tr>");
    }
    
    this.bind_ajax_param_to_link = function(link_id, params, tr_obj) {
        this_obj = this;
        $(link_id).bind('ajax:before', function() {
            if(params != undefined)
            {
                $(this).data('params', params);
            }else
            {
              p = this_obj.get_params_for_sending_ajax_request(tr_obj);
              $(this).data('params', params);
            }
        });
    }
    
    /*Metho for sending ajax post request*/    
    this.get_params_for_sending_ajax_request = function(jquery_obj_for_params, row_id) {
        /*selection of input tags with type=text*/
        input_tags = $("\""+jquery_obj_for_params+"\"").find("input[type='text']");

        var params = {};

        input_tags.each(function(index) {

          input_tag = $(input_tags[index])
          /*Filling hash params for send to server*/
          /*params[objectName[objectFiled]]*/
          params[input_tag.attr("name")] = $("\"input[name='"+input_tag.attr("name")+"']\"").val();
                
        });
        if(typeof row_id != 'undefined')
        {
            params["row_number"]=row_id
        }
        return params;
    }
    
}




