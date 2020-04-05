$( document ).ready(function() {
	
	if($('.div_listbrand').length){
		$('.div_listbrand').mCustomScrollbar();
	}
	if($('.div_listcart').length){
		$('.div_listcart').mCustomScrollbar();
	}
	
	if($(".btn-top").length){
		$(window).scroll(function () {
			var e = $(window).scrollTop();
			if (e > 137) {
				$(".btn-top").fadeIn(400);
			} else {
				$(".btn-top").fadeOut(400);
			}
		});
		$(".btn-top").click(function () {
			$('body,html').animate({
				scrollTop: 0
			});
		});
	}		
	
	
	if($('.show_search').length){
		$(".show_search").click(function() {
            $('.div_cart_gr').removeClass("Show");
            $('.div_login_signup').removeClass("Show");
			if($('.div_input_search').hasClass("Show")){
				$('.div_input_search').removeClass("Show");
				
			}
			else{
			    $('.div_input_search').addClass("Show");
			    $('#searchKeyword').focus();
				
			}
		});
		$(".close_search").click(function() {
			$('.div_input_search').removeClass("Show");
			
		});
	}
	
	if($('.btn_popup_cart').length){
		$(".btn_popup_cart").click(function() {
            $('.div_input_search').removeClass("Show");
            $('.div_login_signup').removeClass("Show");
			if($('.div_cart_gr').hasClass("Show")){
				$('.div_cart_gr').removeClass("Show");
			}
			else{
				$('.div_cart_gr').addClass("Show");				
			}
			
		});
	}
	
    if($('.ico_avatar').length){
		$('.div_login_signup').removeClass("Show");
		$(".ico_avatar").click(function() {
            $('.div_input_search').removeClass("Show");
            $('.div_cart_gr').removeClass("Show");
			if($('.div_login_signup').hasClass("Show")){

				$('.div_login_signup').removeClass("Show");
				
			}
			else{
				$('.div_login_signup').addClass("Show");
				
			}
			
		});
	}
	
	$('.navbar-toggle').click(function() {
		$('.div_login_signup').removeClass("Show");
	});
	
	if($('.select_city').length){
		$(".select_city").select2({
			  placeholder: "Chọn thành phố"
		});
	}
	if($('.select_quan').length){
		$(".select_quan").select2({
		  placeholder: "-Chọn quận-"
		});
	}
	if($('.select_phuong').length){
		$(".select_phuong").select2({
		  placeholder: "-Chọn phường-"
		});
	}
	
	var scroll = $(window).scrollTop();
	if (scroll >= 135) {
		$(".HeaderPage").addClass("scaleheader");
	}
	
	$(window).scroll(function() {    
		var scroll = $(window).scrollTop();
		if (scroll >= 135) {
			$(".HeaderPage").addClass("scaleheader");
		}
		else{$(".HeaderPage").removeClass("scaleheader");}
	});
	
	$('#modal').modal('toggle');
	
});
