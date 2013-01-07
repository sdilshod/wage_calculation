<%if @sch_of_work_info.valid?%>
    var row_id = <%=params[:row_number]%>
    var t_rows = $("table.data_table tbody tr")
    t_rows.each(function(index) {
        if ($(t_rows[index]).find("th").html() == row_id)
        {
           del_link = '<%=link_to "Удалить", sch_of_work_information_path(@sch_of_work_info), :method => :delete, :remote => "true", :id => "delete_row_#{@sch_of_work_info.id}"%>';
           edit_link= '<%=link_to "Редактировать", sch_of_work_information_path(@sch_of_work_info), :remote => "true", :id => "edit_row_#{@sch_of_work_info.id}"%>'
           save_link= '<%=link_to "Сохранить", sch_of_work_information_path(@sch_of_work_info), :method => :put, :remote => "true", :id => "save_row#{@sch_of_work_info.id}" %>'
           
           $(t_rows[index]).find("#delete_row").parent().html(del_link);
           $(t_rows[index]).find("#edit_row").parent().html(edit_link);
           $(t_rows[index]).find("#save_row").parent().html(save_link);    
           
            var link_id = '#<%= "save_row_#{@sch_of_work_info.id}" %>';

            var input_tags = $(link_id).parent().parent().find("input[type='text']");

            input_tags.each(function(index) {
              input_tag = $(input_tags[index])
              input_tag.css("border","none");
            });
                  
        }
    })
<%else%>
    $("div#message_window").append("<%=error_messages(@sch_of_work_info)%>");
    $("div#message_window").css("width","450px");
<%end%>



