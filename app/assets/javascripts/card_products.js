function changeCount(ele) {
    count = $(ele).val();
    $('#product-count').val(count);
}
function calTotal(ele){

  
  $.ajax({
  url: '/card_products/'+$(ele).data("card-product"),
  type: 'put',
  dataType: 'script',
  contentType: 'application/json',
  data: JSON.stringify({ resource:{count: $(ele).val()}, _method:'put' }),
  success: function(data){
    callTotalPrice();
    
  }
})
}
function callTotalPrice(){
  total = 0;
  $('.input-count-product').each(function(){
    el = $(this);
    total += el.data("price")*el.val()
  })
  $('#total-price1').html(total+"đ");
}
function delCardProduct(cpId){
  $.ajax({
  url: '/card_products/'+cpId,
  type: 'delete',
  dataType: 'script',
  contentType: 'application/json',
  success: function(data){
    $("#cp_"+cpId).remove();
    callTotalPrice();
  }
})

}
