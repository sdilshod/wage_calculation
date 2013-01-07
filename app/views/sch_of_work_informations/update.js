
var link_id = '#<%= "save_row_#{@sch_of_work_info.id}" %>';

var input_tags = $(link_id).parent().parent().css("background-color","white").find("input[type='text']");

input_tags.each(function(index) {
  input_tag = $(input_tags[index])
  input_tag.attr("readonly",true);
});

