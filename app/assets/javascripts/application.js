// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require foundation


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

function AddElementsToPage(elements) {
    this.add_calendar_to = function(element_id,font_size){
        if(font_size == undefined){
            font_size = "10px"
        }
        $(element_id).css({"display":"inline","width":"60%","font-size":font_size});
        $(element_id).datepicker({  
            dateFormat: "yy-mm-dd" ,
            nextText: ">>",
            prevText: "<<",
            buttonText: "",
            showOn: "button",
            buttonImage: "/assets/calendar.png",
            buttonImageOnly: true,
            showOtherMonths: true, 
            dayNamesMin: ['Вск', 'Пнд', 'Втр', 'Срд', 'Чтв', 'Птн', 'Сбт'],  
        })

    }

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
        
        var new_row = "<tr class='row_data_table'><td>"+row_number+"</td>";

        $.each(attributes, function(index, item){
            input_tag = "<input id=\""+obj+"_"+item+"_"+row_number+"\" name=\""+obj+"["+item+"]\" size=\"10\"  type=\"text\" value=\"\" />";
            new_row = new_row + "<td>"+input_tag+"</td>";
        })
        new_row = new_row + "<td><span id='edit_row'><img alt='Edit' height='14' src='/assets/panel_tools/edit.png' width='14' /></span></td>"
        new_row = new_row + "<td>"+save_btn+"</td>"
        new_row = new_row + "<td>"+delete_btn+"</td></tr>"
        selector_table.append(new_row)/*.addClass('row_data_table');*/
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
              $(this).data('params', p);
            }
        });
    }
    
    /*Method for sending ajax post request*/    
    this.get_params_for_sending_ajax_request = function(jquery_obj_for_params, row_id, link_id) {
        
        /*selection of input tags with type=text*/
        input_tags = $("\"<tr>"+jquery_obj_for_params+"</tr>\"").find('input[type="text"]');

        var params = {};

        input_tags.each(function(index) {
          input_tag = $(input_tags[index])

          /*Filling hash params for send to server*/
          /*params[objectName[objectFiled]]*/
            f_str = "#"+input_tag.attr("id")
          key_name = input_tag.attr("name");
          if(key_name.match("\[[1-9]+\]")) {
            params[key_name.replace(/\[[1-9]+\]/, "")] = $(link_id).parent().parent().find(f_str).val();

          }else
          {
            params[key_name] = $(link_id).parent().parent().find(f_str).val();
                
          }
        });

        if(typeof row_id != 'undefined')
        {
            params["row_number"]=row_id
        }

        return params;
    }
    
}




