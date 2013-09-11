$(document).ready(function() {
    $('.edit_area').editable('<%= task_path(task) %>',{
      method : 'PUT',  
      type     : 'textarea', 
      submit   : 'OK', 
      cols : '20', 
      rows : '20',
      id   : 'elementid',
      name : 'value', 
      foo : 'bar' 
    });  
  });
