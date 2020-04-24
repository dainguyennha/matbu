$(document).on('turbolinks:load', function() {

    var galleryTop = new Swiper('.gallery-top', {
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 0
    });
    var galleryThumbs = new Swiper('.gallery-thumbs', {
        spaceBetween: 10,
        centeredSlides: true,
        slidesPerView: 'auto',
        touchRatio: 0.2,
        slideToClickedSlide: true,
        autoplay: 5000,
        direction: 'vertical',
    });
    galleryTop.params.control = galleryThumbs;
    galleryThumbs.params.control = galleryTop;


    if ($('.btn_tab1').length) {
        $(".btn_tab1").click(function() {
            if ($('.btn_tab2').hasClass("active")) {
                $('.tab2_info').removeClass("active");
                $(".btn_tab2").removeClass("active");
                $('.tab1_info').addClass("active");
                $('.btn_tab1').addClass("active");
            }

        });
    }
    if ($('.btn_tab2').length) {
        $(".btn_tab2").click(function() {
            if ($('.btn_tab1').hasClass("active")) {
                $('.tab1_info').removeClass("active");
                $(".btn_tab1").removeClass("active");
                $('.tab2_info').addClass("active");
                $('.btn_tab2').addClass("active");
            }

        });
    }
});
