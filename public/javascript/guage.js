percent = $('.bar2 div span').html();
total = $('.bar2').attr('data-total2');
percentStart = 0;

setInterval(function() {
  $('.show2').css('height',percentStart/total*100+'%');
  $('.bar2').css('height',percentStart/total*100+'%');
  $('.bar2 div span').html(percentStart);
  if(percentStart<percent) {percentStart=percentStart+5;}
},1);