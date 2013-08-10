# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$('.task-complete-cb:checkbox').change ->
  $.ajax
    url: '/tasks/' + @value + '/set_complete'
    type: 'PUT'
    data: { completed: $(this).attr('checked') }
    success: -> alert('Task Completed')

$('.task-uncomplete-cb:checkbox').change ->
  $.ajax
    url: '/tasks/'  + @value + '/set_uncomplete'
    type: 'PUT'
    data: { completed: $(this).attr('unchecked') }
    success: -> alert('Task Uncompleted!')
