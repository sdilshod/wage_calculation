# encoding: utf-8

Dir[Rails.root.join("../../bdd_support/*.rb")].each {|f| require f}


module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  
  
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    when /Список графиков работы/
      schedule_of_workings_path

    when /Справочник график работы/
       edit_schedule_of_working

    when /the new work_schedule page/
      new_work_schedule_path

    when /the new work_schedule page/
      new_work_schedule_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
World(ApplicationHelper)
World(ActionView::Helpers::FormTagHelper)
World(ScheduleSupportHelper)
#World(Gherkin::Formatter::AnsiEscapes)
