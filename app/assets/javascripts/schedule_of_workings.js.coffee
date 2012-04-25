# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#add_row_to_nested_model_attr = (f,object,assocation) ->

unbind_click_from_link = (obj)->
 obj.unbind 'click'
 obj.bind 'click', -> false


