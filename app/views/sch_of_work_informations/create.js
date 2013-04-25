<%if @sch_of_work_info.valid?%>
    var row_id = <%=params[:row_number]%>
    var t_rows = $("table.data_table tbody tr")
    t_rows.each(function(index) {
        if ($(t_rows[index]).find("td").html() == row_id)
        {
           del_link = '<%=link_to image_tag("panel_tools/delete.png", :size=>"14x14"), sch_of_work_information_path(@sch_of_work_info), :method => :delete, :remote => "true", :id => "delete_row_#{@sch_of_work_info.id}"%>';
           edit_link= '<%=link_to image_tag("panel_tools/edit.png", :size=>"14x14"), sch_of_work_information_path(@sch_of_work_info), :remote => "true", :id => "edit_row_#{@sch_of_work_info.id}"%>'
           save_link= '<%=link_to image_tag("panel_tools/save.png", :size=>"14x14"), sch_of_work_information_path(@sch_of_work_info), :method => :put, :remote => "true", :id => "save_row_#{@sch_of_work_info.id}" %>'
           
           $(t_rows[index]).find("#delete_row").parent().html(del_link);
           $(t_rows[index]).find("#edit_row").parent().html(edit_link);
           $(t_rows[index]).find("#save_row").parent().html(save_link);    
           
            var link_id = '#<%= "save_row_#{@sch_of_work_info.id}" %>';

            var input_tags = $(link_id).parent().parent().find("input[type='text']");
            $(link_id).parent().parent().find('.ui-datepicker-trigger').hide();    
            input_tags.each(function(index) {
              input_tag = $(input_tags[index])
              input_tag.css("border","none");
            });
                  
        }
    })
<%else%>
    <% @sch_of_work_info.errors.full_messages.each{|e| @err << "#{e}****"} %>
    alert("<%=@err%>".replace(/\*\*\*\*/g, "\n"));
<%end%>



