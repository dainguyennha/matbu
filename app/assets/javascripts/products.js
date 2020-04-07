function enterStar(star, ele){
  $(ele).prevAll('button').css('color', '#fd9727');
  $(ele).css('color', '#fd9727') ;
  $(ele).nextAll('button').css('color', 'gray');
  if(star > 0 && star < 6){
    $('#i-star').val(star);
  }else if(star < 1){
    $('#i-star').val(1);
  }else{
    $('#i-star').val(5);
  }
}
