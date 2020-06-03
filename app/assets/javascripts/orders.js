function updateStatusOrder(id) {
    $("#order-status-submit-btn").click();
    $(".status-label").removeClass("active-label");

    $("label[for=" + id + "]").addClass("active-label");
  //  $("#" + id).parent().prev().remove();

}

function orderChange() {
    $("#find_and_order_btn").click();

}
