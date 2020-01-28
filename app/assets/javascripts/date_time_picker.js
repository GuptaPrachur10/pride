$( document ).on('turbolinks:load', function() {
 $('#datetimepicker').datetimepicker({
   locale: 'en',
   sideBySide: true,
   format: "YYYY-MM-DD h:mm A"
  });
}); 
