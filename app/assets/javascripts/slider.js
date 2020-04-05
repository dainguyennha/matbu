$( document ).ready(function() {
	var swiper = new Swiper('.swiper-container.carousel', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        spaceBetween: 30,
		autoplay:5000,
		loop: true,
        effect: 'fade'
    });
	var swiper3 = new Swiper('.swiper-container.slider_tintuc', {
        slidesPerView: 1,
        paginationClickable: true,
        nextButton: '.swiper-button-next-tintuc',
        prevButton: '.swiper-button-prev-tintuc',
		autoplay:5000,
        spaceBetween: 0,
		effect: 'fade',
		loop: true
    });
	
	var swiper4 = new Swiper('.swiper-container.tintuc_slider', {
        slidesPerView: 4,
        spaceBetween: 10,
		nextButton: '.swiper-button-next-tintucf',
        prevButton: '.swiper-button-prev-tintucf',
		loop: true,
		autoplay:5000,
        pagination: {
			el: '.swiper-pagination',
			clickable: true,
		   },
		breakpoints: {
            1024: {
                slidesPerView: 4,
                spaceBetween: 10
            },
            768: {
                slidesPerView: 4,
                spaceBetween: 8
            },
            640: {
                slidesPerView: 2,
                spaceBetween: 8
            },
            320: {
                slidesPerView: 2,
                spaceBetween: 8
            }
        }
    });
	
	var swiper5 = new Swiper('.swiper-container.tintuc_slider2', {
        slidesPerView: 4,
        spaceBetween: 10,
		nextButton: '.swiper-button-next-tintucf2',
        prevButton: '.swiper-button-prev-tintucf2',
		loop: true,
		autoplay:5000,
        pagination: {
			el: '.swiper-pagination2',
			clickable: true,
		   },
		breakpoints: {
            1024: {
                slidesPerView: 4,
                spaceBetween: 10
            },
            768: {
                slidesPerView: 4,
                spaceBetween: 8
            },
            640: {
                slidesPerView: 2,
                spaceBetween: 8
            },
            320: {
                slidesPerView: 2,
                spaceBetween: 8
            }
        }
    });
	
	var swiper1 = new Swiper('.swiper-container.swiper_sp_moi', {
		pagination: '.swiper-pagination-spmoi',
        paginationClickable: true,
        slidesPerView: 4,
		nextButton: '.swiper-button-next-spmoi',
        prevButton: '.swiper-button-prev-spmoi',
		autoplay:5000,
        spaceBetween: 8,
		loop: true,
        breakpoints: {
            1024: {
                slidesPerView: 4,
                spaceBetween: 10
            },
            768: {
                slidesPerView: 3,
                spaceBetween: 8
            },
            640: {
                slidesPerView: 1,
                spaceBetween: 0
            },
            320: {
                slidesPerView: 1,
                spaceBetween: 0
            }
        }
    });
	var swiper2 = new Swiper('.swiper-container.swiper_comment', {
		pagination: '.swiper-pagination-comment',
        paginationClickable: true,
        slidesPerView: 1,

		autoplay:5000,
        spaceBetween: 0,
		loop: true,
        breakpoints: {
            1024: {
                slidesPerView: 1,
                spaceBetween: 0
            },
            768: {
                slidesPerView: 1,
                spaceBetween: 0
            },
            640: {
                slidesPerView: 1,
                spaceBetween: 0
            },
            320: {
                slidesPerView: 1,
                spaceBetween: 0
            }
        }
    });
	
	
	
	$( '#slider-home' ).sliderPro({
			width: 960,
			height: 497,
			fade: true,
			arrows: false,
			buttons: false,
			fullScreen: false,
			shuffle: true,

			thumbnailWidth: 169,
			thumbnailHeight: 55,
			thumbnailArrows: true,
			autoplay: true,
			breakpoints: {
				768: {
					thumbnailWidth: 127,
					thumbnailHeight: 41
				},
				475: {
					thumbnailWidth: 170,
					thumbnailHeight: 55
				},
				375: {
					thumbnailWidth: 170,
					thumbnailHeight: 55
				},
				320: {
					thumbnailWidth: 170,
					thumbnailHeight: 55
				}
			}
		});
	

});
