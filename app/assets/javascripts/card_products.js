function changeCount(ele) {
    count = $(ele).val();
    $('#product-count').val(count);
    $('#product-count-buy').val(count);
}

function calTotal(ele) {


    $.ajax({
        url: '/card_products/' + $(ele).data("card-product"),
        type: 'put',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify({
            resource: {
                count: $(ele).val()
            },
            _method: 'put'
        }),
        success: function(data) {
            $('#input-count-product-page_' + $(ele).data("card-product")).val(data.count);
            $('#input-count-product_' + $(ele).data("card-product")).val(data.count);
            callTotalPrice();
            callTotalPricePage();

        }
    })
}

function callTotalPrice() {
    total = 0;
    count = 0;
    $('.input-count-product').each(function(index) {
        el = $(this);
        total += el.data("price") * el.val()
        count = index + 1;
    })
    $('#total-price1').html(total + " đ");
    $('#count-product-id').html(count);
    if (count == 0) {
        $(".btn-buy").replaceWith("<a class='btn btn-primary btn_big' disabled>thanh toán</a>");
    }


}

function callTotalPricePage() {
    total = 0;
    var count = 0;
    $('.input-count-product-page').each(function(index) {
        el = $(this);
        total += el.data("price") * el.val()
        count = index + 1;
    })
    $('#total-price1-page').html(total + " đ");
    $('#count-product-page-id').html(count);
    if (count == 0) {
        $(".btn-buy-page").replaceWith("<a class='btn btn-primary right' disabled>thanh toán</a>");
    }
}

function delCardProduct(cpId) {
    $.ajax({
        url: '/card_products/' + cpId,
        type: 'delete',
        dataType: 'script',
        contentType: 'application/json',
        success: function(data) {
            $("#cp_" + cpId).remove();
            $("#cp-page_" + cpId).remove();

            callTotalPrice();
            callTotalPricePage();
        }
    })

}

function closeCart() {
    $('#id_cart_gr').remove();

}
