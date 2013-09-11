 //$(document).ready(function() {
 //         $('.edit').editable('<%=h link_to "Update", task_path(task), :method => :put %>');
 //          });
$(document).on('click', '.btn-moar', function() {
//var the_class = $(this).
//alert( "Handler for .click() called."+the_class+"fof" );
$('.moar').slideDown().css('display','block');
$(this).removeClass('btn-moar');
$(this).addClass('btn-moar-down');
$('#btn-moar-icon').removeClass('icon-double-angle-down icon-3x');
$('#btn-moar-icon').addClass('icon-double-angle-up icon-3x');
});

$(document).on('click', '.btn-moar-down', function() {
//alert( "Handler for .click() called." );
$('.moar').fadeOut().css('display','none');
$(this).removeClass('btn-moar-down');
$(this).addClass('btn-moar');
$('#btn-moar-icon').removeClass('icon-double-angle-up icon-3x');
$('#btn-moar-icon').addClass('icon-double-angle-down icon-3x');
});

