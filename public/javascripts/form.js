$(document).ready(function() {
  $('input[title!=""]').hint();
  $("#posting_from_date, #posting_to_date").datepicker();
  $("#posting_from_date, #posting_to_date").change(function() {
    $(this).removeClass('blur');
  });
});

