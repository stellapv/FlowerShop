/*!
	Zoom 1.7.14
	license: MIT
	http://www.jacklmoore.com/zoom
*/
(function ($) {
  var defaults = {
    url:false,
    callback:false,
    target:false,
    duration:120,
    on: "mouseover",
    touch:true,
    onZoomIn:false,
    onZoomOut:false,
    magnify:1
  };
  $.zoom=function(target,source,img,magnify) {
    var targetHeight,
      targetWidth,
      sourceHeight,
      sourceWidth,
      xRatio,
      yRatio,
      offset,
      $target=$(target),
      position=$target.css("position"),
      $source=$(source);

    $target.css("position",/(absolute|fixed)/.test(position)?position:"relative");
    $target.css("overflow","hidden");

    img.style.width=img.style.height="";

    $(img)
      .addClass("zoomImg")
      .css({
        position:"absolute",
        top:0,
        left:0,
        opacity:0,
        width: img.width*magnify,
        height :img.height*magnify,
        border:"none",
        maxWidth:"none",
        maxHeight:"none"
      })
      .appendTo(target);
    return {
      init:function(){
        targetWidth=$target.outerWidth();
        targetHeight=$target.outerHeight();

        if(source===$target[0]){
          sourceWidth=targetWidth;
          sourceHeight=targetHeight}
        else{
          sourceWidth=$source.outerWidth();
          sourceHeight=$source.outerHeight()
        }

        xRatio=(img.width-targetWidth)/sourceWidth;
        yRatio=(img.height-targetHeight)/sourceHeight;

        offset=$source.offset()
      },
      move:function(e){
        var left=e.pageX-offset.left,
          top=e.pageY-offset.top;

        top=Math.max(Math.min(top,sourceHeight),0);
        left=Math.max(Math.min(left,sourceWidth),0);

        img.style.left=left*-xRatio+"px";
        img.style.top=top*-yRatio+"px"
      }
    }
  };

  $.fn.zoom=function(options){
    return this.each(function(){
      var 
      settings=$.extend({},defaults,options||{}),
      target=settings.target||this,
      source=this,
      $source=$(source),
      $target=$(target),
      img=document.createElement("img"),
      $img=$(img),
      mousemove="mousemove.zoom",
      clicked=false,
      touched=false,
      $urlElement;

      if(!settings.url){
        $urlElement=$source.find("img");
        if($urlElement[0]){
          settings.url=$urlElement.data("src")||$urlElement.attr("src")
        }
        if(!settings.url){
          return
        }
      }
      (function(){
        var position=$target.css("position");
        var overflow=$target.css("overflow");

        $source.one("zoom.destroy",function(){
          $source.off(".zoom");
          $target.css("position",position);
          $target.css("overflow",overflow);
          $img.remove();
        });
      })();
      
      img.onload=function(){
        var zoom=$.zoom(target,source,img,settings.magnify);

        function start(e){
          zoom.init();
          zoom.move(e);

          $img.stop()
          .fadeTo($.support.opacity?settings.duration:0,1,$.isFunction(settings.onZoomIn)?settings.onZoomIn.call(img):false)
        }

        function stop(){
          $img.stop().fadeTo(settings.duration,0,$.isFunction(settings.onZoomOut)?settings.onZoomOut.call(img):false)
        }

        zoom.init();

        $source
          .on("mouseenter.zoom",start)
          .on("mouseleave.zoom",stop)
          .on(mousemove,zoom.move)
        

        if(settings.touch){
          $source
            .on("touchstart.zoom", function(e){
              e.preventDefault();
              if(touched){
                touched=false;
                stop()
              }else{
                touched=true;
                start(e.originalEvent.touches[0]||e.originalEvent.changedTouches[0])
              }
            })
            .on("touchmove.zoom", function(e){
              e.preventDefault();
              zoom.move(e.originalEvent.touches[0]||e.originalEvent.changedTouches[0])
            })
        }

        if($.isFunction(settings.callback)){
          settings.callback.call(img)
        }
      };

      img.src=settings.url
    })
  };

    $.fn.zoom.defaults=defaults
})(window.jQuery);