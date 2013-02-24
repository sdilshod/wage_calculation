module AccountJournalHelper

  def charge_to_html charges
    st=""
    charges.each do |e|
      st += <<-STR
        <tr>
          <td> #{e.type_of_calc} </td>
          <td> #{e.year_month} </td>
          <td> #{e.hour} </td>
          <td> #{e.day} </td>
          <td> #{sprintf("%0.2f",e.summ)} </td>
        </tr>
      STR
    end
    st.gsub(/\n/,"").html_safe
  end  
  def deductions_to_html deductions
    st=""
    deductions.each do |e|
      st += <<-STR
        <tr>
          <td> #{e.type_of_calc} </td>
          <td> #{e.year_month} </td>
          <td> #{sprintf("%0.2f",e.summ)} </td>
        </tr>
      STR
    end
    st.gsub(/\n/,"").html_safe
  end  


end
