$(document).ready(function(){
    var slide = $(".slide");
    var viewWidth = $(window).width();
    var sliderInner = $(".slider-inner");
    var childrenNo = sliderInner.children().length;
    
    sliderInner.width( viewWidth * childrenNo );
    
    $(window).resize(function(){
        viewWidth = $(window).width();
    });
    
    function setWidth(){
        slide.each(function(){
            $(this).width(viewWidth);
            $(this).css("left", viewWidth * $(this).index());
        }); 
    }
    
    function setActive(element){
        var clickedIndex = element.index();
        
        $(".slider-nav .active").removeClass("active");
        element.addClass("active");
        
        sliderInner.css("transform", "translateX(-" + clickedIndex * viewWidth + "px) translateZ(0)");
        
        $(".slider-inner .active").removeClass("active");
        $(".slider-inner .slide").eq(clickedIndex).addClass("active");
    }
    
    setWidth();
    
    $(".slider-nav > div").on("click", function(){
        setActive($(this));
    });
    
    $(window).resize(function(){
        setWidth();
    });
    
    setTimeout(function(){
        $(".slider").fadeIn(500);
    }, 10);
});
//上面是首頁的換頁



$(document).ready(function(){
  $('a.page-scroll').bind('click', function(event) {//將所有a標籤且擁有page-scroll class的元素綁上click(點擊)事件
        var $anchor = $(this);//將$anchor指向 觸發點擊的a元素(jquery物件型式)
        $('html, body').stop().animate({//對網頁進行scroll(捲動)
            scrollTop: ($($anchor.attr('href')).offset().top - 50)
        }, 1250, 'easeInOutExpo');//該捲動動作在1.25秒內完成 使用時間函數easeInOutExpo
        event.preventDefault();//取消a元素原本的點擊事件(轉跳)
    });
});
//上面是滑動頁面



$(function() {
      var showcase = $("#showcase"), title = $('#item-title')

      showcase.Cloud9Carousel( {
        yOrigin: 42,
        yRadius: 48,
        mirror: {
          gap: 12,
          height: 0.2
        },
        buttonLeft: $("#nav > .left"),
        buttonRight: $("#nav > .right"),
        autoPlay: 1,
        bringToFront: true,
        onRendered: rendered,
        onLoaded: function() {
          showcase.css( 'visibility', 'visible' )
          showcase.css( 'display', 'none' )
          showcase.fadeIn( 1500 )
        }
      } )

      function rendered( carousel ) {
        title.text( carousel.nearestItem().element.alt )

        // Fade in based on proximity of the item
        var c = Math.cos((carousel.floatIndex() % 1) * 2 * Math.PI)
        title.css('opacity', 0.5 + (0.5 * c))
      }

      //
      // Simulate physical button click effect
      //
      $('#nav > button').click( function( e ) {
        var b = $(e.target).addClass( 'down' )
        setTimeout( function() { b.removeClass( 'down' ) }, 80 )
      } )

      $(document).keydown( function( e ) {
        //
        // More codes: http://www.javascripter.net/faq/keycodes.htm
        //
        switch( e.keyCode ) {
          /* left arrow */
          case 37:
            $('#nav > .left').click()
            break

          /* right arrow */
          case 39:
            $('#nav > .right').click()
        }
      } )
    })
//上面是球球滾動