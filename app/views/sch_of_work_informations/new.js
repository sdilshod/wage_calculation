

var obj = new AddElementsToPage();
    
var btn_save = '<%=link_to "Сохранить", sch_of_work_informations_path, :method => :post, :remote => "true", :id => "save_row"%>'
var btn_delete = '<%=link_to "Удалить", nil, :id => "delete_row", :href=>"#", :onclick=>"$(this).parent().parent().remove(); return false;"%>'
var obj_attributes = ["date","schedule_code","hour","night_time"]


var n_row = obj.add_row_to_data_table("sch_of_work_information",obj_attributes, $('.data_table'),btn_save,btn_delete)


var row_id = $(n_row).find("th[scope='row']").html();

alert(obj.get_params_for_sending_ajax_request(n_row, row_id, "#save_row"))


$(function() {
    $('#save_row').bind('ajax:before', function() {
        $(this).data('params', obj.get_params_for_sending_ajax_request(n_row, row_id, "#save_row"));
    });
});


