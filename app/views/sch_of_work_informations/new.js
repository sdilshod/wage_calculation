

var obj = new AddElementsToPage();
    
var btn_save = '<%=link_to image_tag("panel_tools/save.png", :size=>"14x14"), sch_of_work_informations_path, :method => :post, :remote => "true", :id => "save_row"%>'
var btn_delete = '<%=link_to image_tag("panel_tools/delete.png", :size=>"14x14"), nil, :id => "delete_row", :href=>"#", :onclick=>"$(this).parent().parent().remove(); return false;"%>'
var obj_attributes = ["date","schedule_code","hour","night_time"]


var n_row = obj.add_row_to_data_table("sch_of_work_information",obj_attributes, $('.data_table'),btn_save,btn_delete)

/*$(n_row).addClass("row_data_table");*/
var row_id = $(n_row).find("td").html();

calendar_el = "#sch_of_work_information_date_"+row_id;
obj.add_calendar_to(calendar_el);


$("#save_row").focus();
$(function() {
    $('#save_row').bind('ajax:before', function() {
       p=obj.get_params_for_sending_ajax_request(n_row, row_id, "#save_row")
       $(this).data('params', p);
    });

});


