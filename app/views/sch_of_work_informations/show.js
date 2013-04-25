
var obj = new AddElementsToPage();

var link_id = '#<%= "save_row_#{@sch_of_work_info.id}" %>';


var el_tr = $(link_id).parent().parent();
el_tr.css("background-color","#CCC");
el_tr.find('input[data-calendar]').parent().find('img').show();

var input_tags = el_tr.find("input[type='text']");

input_tags.each(function(index) {
  input_tag = $(input_tags[index])
  input_tag.attr("readonly",false);
});



$(function() {
    $(link_id).bind('ajax:before', function() {
        p = obj.get_params_for_sending_ajax_request("<tr>"+el_tr.html()+"</tr>", undefined, link_id)
        p["id"] = <%=@sch_of_work_info.id%>
        $(this).data('params', p);
    });
});

