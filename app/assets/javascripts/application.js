// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap.min
//= require jquery_zoom


function hidemenu(x) {
    x.parentNode.className = "dropdown";
}

$(document).ready(function(){
  searchPosition();
});

function setDropDownCSS() {
  a= document.getElementsByClassName("dropdown-toggle")
  for(b=0; b<a.length;b++) {
    a[b].className="dropdown-toggle dropdown-anchor hvr-icon-hang";
  }
}

function searchPosition() {
 usericon = document.getElementsByClassName("glyphicon-user")[0];
  var s = document.getElementsByClassName("navbar-left")[0];
   if (usericon != undefined) {
     s.style.right = "95%";
   } else { 
    s.style.marginLeft = "16%";
   }

}

function showSearch() {
  var s = $("#q").show(1000);

}

function bckgrnd() {
  elements = document.getElementsByClassName("dropdown-toggle")
  for(i=0;i<elements.length;i++) {
    elements[i].style="color:black;background-color:#FAEBD7;"
  }
}