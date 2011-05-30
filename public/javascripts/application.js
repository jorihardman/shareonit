$(document).ready(function() {
  //jquery-ui setup
  $('.button').button();
  $('.buttonset').buttonset();
  
  //fancybox setup
  $('a[rel*=facebox]').fancybox({
	  'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'showNavArrows': false 
  });
  
  //posting form
  if ($('#posting_free_true').is(':checked')) {
    $('#price').hide();
  }
  
  $('#posting_free_true, #posting_free_false').change(function() {
    $('#price').toggle();
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
