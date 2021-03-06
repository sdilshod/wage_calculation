# encoding: utf-8

#Вспомогательные методы
def new_05_schedule(h)
  schedule_051 = Factory.build(:schedule_051, h)
  schedule_051.cycles.build collection_of_cycles
  schedule_051.date_of_countings.build collection_date_of_countings
  return schedule_051
end

#

#------------------------------------------------
#      Создание нового графика
#-----------------------------------------------

Given /^я перешел на страницу "([^"]*)"$/ do |arg1|
  #Список графиков работы
  visit schedule_of_workings_path
end

Then /^я должен увидеть кнопку "([^"]*)"$/ do |create| #Кнопка создать
  page.should have_selector('a')
end

  When /^я нажму на кнопку "([^"]*)"$/ do |create|
    visit new_schedule_of_working_path
    
	  @schedule_of_working = ScheduleOfWorking.new
	  @schedule_of_working.should be_new_record
    
  end

    Then /^я увижу форму ввода$/ do
	    page.should have_selector('form')
    end

    Then /^увижу текст "([^"]*)"$/ do |text|
      page.should have_content(text)
    end

    Then /^увижу текстовый поля "([^"]*)", "([^"]*)"$/ do |schedule_name, schedule_code|
	    page.should have_selector("input##{schedule_name}")
	    page.should have_selector("input##{schedule_code}")
    end
    

    Then /^должен увидеть таблицу для вносение циклов графика с загаловкой "([^"]*)"/ do |cycle|
      page.should have_content(cycle)
    end

    Then /^я введу в поле "([^"]*)" значение "([^"]*)"$/ do |schedule_of_working_name, value|
      fill_in(schedule_of_working_name, :with => value)
      @schedule_of_working.name = value
    end

    Then /^введу в поле "([^"]*)" значение "([^"]*)"$/ do |schedule_of_working_schedule_code, value|
      fill_in(schedule_of_working_schedule_code, :with => value)
      @schedule_of_working.schedule_code = value
    end

    Then /^должен увидеть кнопку для таблицы Циклов "([^"]*)"$/ do |add_button|
      page.should have_selector("a[@id='create_row_cycle']")
      @schedule_of_working.name.should_not be_nil
      @schedule_of_working.schedule_code.should_not be_nil
    end

      When /^я нажму кнопку "([^"]*)"$/ do |create_row|
        click_link(create_row)
      end
      
      Then /^в таблицу циклов должно добавиться пустая строка с полями вводов$/ do 
        find(:xpath,"//div[@id='cycleform']/table").should have_css("tr td input[@type='text']")
      end

      Then /^я заполню строку таблицы с данными$/ do |table|
        hash_for_filling = table.hashes[0]
        fill_in("schedule_of_working_cycles_attributes_new_cycles_day", :with => hash_for_filling['day'])
        fill_in("schedule_of_working_cycles_attributes_new_cycles_hour", :with => hash_for_filling['hour'])
        fill_in("schedule_of_working_cycles_attributes_new_cycles_night_time", :with => hash_for_filling['hour_night'])
        
        @schedule_of_working.cycles_attributes = table.hashes
        @schedule_of_working.cycles.size.should == table.hashes.size
        
        #На этом шаги надо просмотрить заполнение полей в цикле
        
 #       table.hashes.each do |hash|
 #         within(:xpath,"//div[@id='cycleform']/table/tr[#{table.hashes.index(hash)+1}]") do
 #           fill_in("schedule_of_working_new_cycle_attributes__day", :with => hash['day'])
 #           fill_in("schedule_of_working_new_cycle_attributes__hour", :with => hash['hour'])
 #           fill_in("schedule_of_working_new_cycle_attributes__hour_night", :with => hash['hour_night'])
 #         end
 #       end
     #   table.hashes.each do |hash|
     #     within(:xpath,"//div[@id='cycleform']/table/tr[#{table.hashes.index(hash)}]") do
     #     end
     #   end
      end

    Then /^должен увидеть таблицу для вносение сменов с датами отсчетов с загаловкой "([^"]*)"$/ do |date_counting|
      page.should have_content(date_counting)  
    end

    Then /^должен увидеть кнопки для таблицы Даты отсчета смен "([^"]*)"$/ do |add_button|
      page.should have_selector("a[@id='create_row_date_counting']")
    end
    
      When /^я нажму кнопку дата отсчета "([^"]*)"$/ do |create_row|
        find('div#date_counting_form a').click
      end
    
      Then /^в таблицу даты отчсета смен должно добавиться пустая строка с полями вводов$/ do
        find(:xpath,"//div[@id='date_counting_form']/table").should have_css("tr td input[@type='text']")
      end

      Then /^я заполню строку таблицы с данными дата отсчет$/ do |table|
        table.hashes.each do |hash|
          fill_in("schedule_of_working_date_of_countings_attributes_new_date_of_countings_session_number", :with => hash['session_number'])
          fill_in("schedule_of_working_date_of_countings_attributes_new_date_of_countings_initial_day", :with => hash['initial_day'])
          fill_in("schedule_of_working_date_of_countings_attributes_new_date_of_countings_counting_date", :with => hash['counting_date'])
        end
        
        @schedule_of_working.date_of_countings_attributes = table.hashes
        @schedule_of_working.date_of_countings.size.should == table.hashes.size
        

      end

    Then /^должен увидeть кнопку "([^"]*)"$/ do |save_button|
      page.should have_selector("input[@value=#{save_button}]")
    end


    When /^я нажму кнопку "([^"]*)" и отправлю форму на сервер$/ do |submit_button|
      click_button(submit_button)

    end

    Then /^я увижу сообщение "([^"]*)"$/ do |mess|
      @schedule_of_working = ScheduleOfWorking.find_by_schedule_code("05")
      page.should have_content(mess)
      @schedule_of_working.should_not be_blank
      @schedule_of_working.should be_valid
    end

#------------------------------------------------------------------------
#      Редактирование сушествующего графика
#------------------------------------------------------------------------

Given /^я нахожусь на страницы "([^"]*)" и в справочники графиков работы есть пока одна запись$/ do |title, table|
  h = table.hashes[0].symbolize_keys
  h.delete(:edit_button)
  @schedule_051 = new_05_schedule h

  @schedule_051.save
  visit schedule_of_workings_path
  page.should have_content(title)
end

When /^я нажму ссылку "([^"]*)"$/ do |edit|
  visit edit_schedule_of_working_path(@schedule_051.id)
end

Then /^я увижу форму редактирование графика с заголовкой "([^"]*)"$/ do |form_title|
  page.should have_content(form_title)
end

Then /^цикл графика будить таковым$/ do |table|
   @schedule_051.cycles.count.should == table.hashes.size
end

Then /^даты отсчеты будить таковым$/ do |table|
  @schedule_051.date_of_countings.count.should == table.hashes.size
end

When /^я удалю запись цикла и нажму кнопку "([^"]*)"$/ do |save_button|
  find('div#cycleform div table a').click
  click_button(save_button)
end

Then /^я увижу "([^"]*)"$/ do |mess|
  page.should have_content(mess)  
  @schedule_051.cycles.count.should == 6
end

Then /^график сохраниться с изменениями в БД$/ do
  @schedule_051.should be_valid
end

#---------------------------------------
#       Удаление графика
#---------------------------------------

Then /^я нажму ссылку для удаление "([^"]*)" то увижу потверждение$/ do |delete_button|
  find(".data_table a[@data-method='delete']").click
end

When /^я не соглашусь на удаление не чего не происходить и запись не удалиться$/ do
  page.driver.browser.switch_to.alert.dismiss
end

When /^соглашусь на удаление$/ do
  find(".data_table a[@data-method='delete']").click
  page.driver.browser.switch_to.alert.accept
end

Then /^запись удалиться из БД и увижу "([^"]*)"$/ do |msg|
  page.should have_content(msg)
end

#-----------------------------------------------
# Формирование сведение о графики работы
#-----------------------------------------------

Given /^в базе графиков работы есть следующий записи$/ do |table|
#  h = table.hashes[0].symbolize_keys
#  @schedule_051 = new_05_schedule h
#  @schedule_051.save
  @schedule_05 = Factory.build :schedule_05
  @schedule_05.save
end

When /^я перешел по ссылки "([^"]*)"$/ do |link|
  visit filling_schedule_of_workings_path
end

  Then /^я должен увидeть форму с заголовкой "([^"]*)"$/ do |form_title|
    page.should have_content(form_title)
  end

  Then /^должен увидeть поля ввода "([^"]*)" и "([^"]*)"$/ do |field_date_begin, field_date_end|
	  page.should have_selector("input##{field_date_begin}")
	  page.should have_selector("input##{field_date_end}")
  end

  Then /^должен увидeть поля списка "([^"]*)" и "([^"]*)"$/ do |field_list, field_list2|
	  page.should have_selector("select##{field_list}")
	  page.should have_selector("select##{field_list2}")
  end

  Then /^должен увидeть кнопку "([^"]*)" в форме заполнение$/ do |runs|
    page.should have_selector("input[@value=#{runs}]")
  end

  When /^я нажму на кнопку "([^"]*)" в форме заполнение$/ do |runs|
    click_button(runs)
  end

  Then /^должен увидeть надпись "([^"]*)" в форме заполнение$/ do |message|
    page.driver.browser.switch_to.alert.accept
  end

  When /^я заполню поля ввода "([^"]*)" с значением "([^"]*)" и "([^"]*)" с значением "([^"]*)"$/ do |field_date_begin, val1,field_date_end, val2|
    fill_in(field_date_begin, :with => val1)
    fill_in(field_date_end, :with => val2)
  end

  When /^нажму кнопку "([^"]*)" в форме заполнение$/ do |runs|
    click_button(runs)
    sleep 15
  end

#  When /^я буду ждать пока ajax запрос закончиться$/ do
#    wait_until do
#      page.evaluate_script('$.active') == 0
#    end
#  end  
  
  Then /^количество записи в сведение графиков для классификатора "([^"]*)" будить 365$/ do |schedule_class|
    puts "count of rows #{ScheduleOfWorking.count}"
    s_c = ScheduleOfWorking.find_by_schedule_code("05")
    puts "05 schedule is presents #{s_c.blank?}"
    unless s_c.blank?
      puts "05 schedule is presents #{s_c.date_of_countings.blank?}"
    end
    SchOfWorkInformation.count.should == 365
  end


#-----------------------------------------------
# Прямая коррекция сведение графиков работы
#-----------------------------------------------


Given /^в базе сведение графиков работы есть следующий записи$/ do |table|
  # table is a Cucumber::Ast::Table
  @schedule_05 = Factory.build :schedule_05
  @schedule_05.save
  h = table.hashes
  h.each do |e|
    SchOfWorkInformation.create e.symbolize_keys
  end
end

When /^я перешел по ссылки для корректировки сведение графиков работы "([^"]*)"$/ do |link|
  visit sch_of_work_informations_path
end

  Then /^я должен увидить список сведение графиков работы с пагинации (\d+) строк в страницы$/ do |arg1|
    page.should have_selector("table.data_table")
  end

  And /^должен уведить кнопку "([^"]*)"$/ do |btn_add|
    page.should have_selector("a span.add")
  end

#добавление
When /Если я нажму кнопку "([^"]*)"$/ do |btn_add|
  click_button btn_add
end

  Then /^в таблице появиться новая строка$/ do
    find(:xpath, "//table[@class='data_table']").should have_css("tr td input[@type='text']")
  end

  And /^я заполню поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)"$/ do |date, value1, schedule_code, value2|
    fill_in(date, :with => value1)
    fill_in(schedule_code, :with => value2)
    @t_row = find("##{date}").parent
  end

When /^я нажму кнопку "([^"]*)" в строки$/ do |btn_save|
  @t_row.find("td a#save_row").click()
end

  Then /^увижу сообщение об ошибки в добавление "([^"]*)"$/ do |str_message|
    @error_el = find("#message_window")
    @error_el.text.should =~ /#{str_message}/
    @error_el.find("a").click()
  end

When /^я заполню поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)"$/ do |txt_date, value1, txt_schedule_code, value2, txt_hour, value3|
    fill_in(txt_date, :with => value1)
    fill_in(txt_schedule_code, :with => value2)
    fill_in(txt_hour, :with => value3)
end

  And /^нажму на "([^"]*)" \(добавление\)$/ do |arg1|
      @t_row.find("td a#save_row").click()
  end

  Then /^таблица сведение графиков работы увеличиться на одну запись$/ do 
    SchOfWorkInformation.count.should == 8
  end

#correction
When /^на первом строки кликаю мышью$/ do
  t_rows = find("table.data_table tbody tr td",:text => "1")
  puts t_rows
  puts t_rows.text
end

  Then /^поля становиться read\-only=false$/ do
    pending # express the regexp above with the code you wish you had
  end

  And /^я заполню поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)" \(correction\)$/ do |date, hour|
    pending # express the regexp above with the code you wish you had
  end

When /^я нажму кнопку "([^"]*)" в строки редактирование$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

  Then /^увижу сообщение об ошибки в корректировки "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
  end

When /^я заполню поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)", поля "([^"]*)" с значением "([^"]*)" \(correction\)$/ do |txt_date, value1, txt_schedule_code, value2, txt_hour, value3|
  pending # express the regexp above with the code you wish you had
end

  And /^нажму на "([^"]*)" \(корректировка\)$/ do |arg1|
    pending # express the regexp above with the code you wish you had
  end

  Then /^увижу сообщение в корректировки "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
  end



