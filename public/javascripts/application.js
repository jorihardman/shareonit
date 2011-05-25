$(document).ready(function() {
  //jquery-ui setup
  $('.button').button();
  $('.buttonset').buttonset();
  
  //facebox setup
  $('a[rel*=facebox]').facebox({
    loadingImage : '/images/loading.gif',
    closeImage   : '/images/closelabel.png'
  });
  
  $('#new_posting').submit(function() {
    $.facebox.close();
    return true;
  });
});

//google analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-10595318-9']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
