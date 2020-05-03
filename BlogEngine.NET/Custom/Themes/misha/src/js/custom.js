// add placeholder to newsletter widget.
$("#txtNewsletterEmail").attr("placeholder", "youremail@example.com");

//
$('[data-toggle="tooltip"]').tooltip();


$(".blog-search-toggle").click(function () {
  $(".blog-header-search").fadeIn().focus();
})


$(".blog-header-search").blur(function () {
  $(".blog-header-search").fadeOut();
})

$(".blog-nav ul").each(function () {
    var $this = $(this);
    if ($this.find("li").length) {
        $this.parent().addClass("has-ul").append('<i class="fa fa-chevron-down nav-item-toggle"></i>');
    }
});

//
$(".blog-nav-toggle").on("click", function () {
    $(this).toggleClass("is-active");
    $(".blog-nav").slideToggle();
});


//
$(".nav-item-toggle").on("click", function () {
    $(this).toggleClass("is-active");
    $(this).parent().find("ul").toggleClass("is-active");
});

$(function () {
    // social networks
    var socialNetwork = $(".blog-social li a");
    for (i = 0; i < socialNetwork.length; ++i) {
        link = socialNetwork[i];

        if ($(link).attr("href") != "") {
            $(link).parent().css("display", "block");
        }
    }
});

// back up
$("#back-up").on('click', function (e) {
    e.preventDefault();
    $('html,body').animate({
        scrollTop: 0
    }, 700);
});

$(window).scroll(function(){
  if ($(window).scrollTop() > 100 ){
    $("#back-up").css('bottom', '0');
  } else {
    $("#back-up").css('bottom','-4rem');
  }
});


// slideshow
if (slideItems > 4) {
    slideItems = 4
}

var slideItems800 = 1;
if (slideItems >= 3) {
    slideItems800 = 2;
} else if (slideItems >= 2) {
    slideItems800 = 1;
}

$("#widgetzone_slider .postlist ul").addClass("owl-carousel");

$('.owl-carousel').owlCarousel({
    loop: true,
    margin: 0,
    nav: false,
    dots: false,
    responsiveClass: true,
    navSpeed: 500,
    autoplay: true,
    autoplayTimeout: 7000,
    autoplaySpeed: 700,
    responsive: {
        0: {
            items: 1
        },
        800: {
            items: slideItems800
        },
        1281: {
            items: slideItems,
            nav: true
        }
    },
    navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>']
});
$("#widgetzone_slider .postlist ul").show();

//
var simpleCap = $("label[for=simpleCaptchaValue]").parent();
simpleCap.remove();
$("#commentCaptcha").append(simpleCap.html());
