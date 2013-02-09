<%if @worker%>
  $("#worker_name").html('<%=@worker.name%>')
<%else%>
  alert('Сотрудник с таким таб№ не найдено')
<%end%>

