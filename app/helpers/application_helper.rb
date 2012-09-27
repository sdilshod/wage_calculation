module ApplicationHelper

  def error_messages(obj, title_message=I18n.t(:title_of_error_message))
    return "" if obj.errors.blank?
    str = "<div class='error_message'><p>#{title_message}<a OnClick='$(this).parent().parent().remove();$(\'div#message_window\').css(\'width\',\'1px\');return false;' href='#' style='float:right;color:yellow;font-weight:bold;text-decoration:none;'>X</a></p><ul>"; 
    
    obj.errors.full_messages.each{|e| str << "<li>#{e}</li>"}
    str << "</ul></div>"
    str.html_safe
  end
 
end
