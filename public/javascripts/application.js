$(document).ready(function() {
  //jquery-ui setup
  $('.button').button();
  $('.buttonset').buttonset();
  $('.date').datepicker();
  
  //facebox setup
  $('a[rel*=facebox]').facebox({
    loadingImage : '../images/loading.gif',
    closeImage   : '../images/closelabel.png'
  });
});
