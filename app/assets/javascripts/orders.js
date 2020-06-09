function updateStatusOrder(id) {
    $("#order-status-submit-btn").click();
    $(".status-label").removeClass("active-label");

    $("label[for=" + id + "]").addClass("active-label");
    //  $("#" + id).parent().prev().remove();

}

function orderChange() {
    $("#find_and_order_btn").click();

}

function dateChange(ele) {
    $("#month-input").val();

    var date = new Date($(ele).val());

    var firstTime = date.setHours(0, 0, 0, 0);
    var lastTime = date.setHours(23, 59, 59, 999);

    $("#begin-time").val(Math.round(firstTime / 1000));
    $("#end-time").val(Math.round(lastTime / 1000));
    $("#date_month_submit").click();


}

function monthChange(ele) {
    $("#date-input").val();
    var date = new Date($(ele).val()),
        y = date.getFullYear(),
        m = date.getMonth();
    var firstTime = new Date(y, m, 1);
    var lastTime = new Date(y, m + 1, 0);

    $("#begin-time").val(Math.round(firstTime.getTime() / 1000));
    $("#end-time").val(Math.round(lastTime.setHours(23, 59, 59, 999) / 1000));
    $("#date_month_submit").click();
}
