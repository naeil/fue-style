
library testing;

import 'package:test/test.dart';

import "../lib/fue_style.dart";

class Style extends StyleBase{}

main() {

  test("background", (){
    var a = new Style(), b = new Style();
    a.background = "url('http://asd.zxc') 25% center no-repeat #39f";
    expect(a.cssText, 'background:#ff3399ff url("http://asd.zxc") 25% center no-repeat;');
  });

  test("height", (){
    var a = new Style();
    a.height = "10px";
    expect(a.cssText, "height:10px;");
  });

  
  test("border 1", (){
    var a = new Style();
    a.border = "1px #555 solid";
    expect(a.cssText, "border:1px #ff555555 solid;");
  });

  test("border 2", (){
    var a = new Style();
    a.border = "1px";
    expect(a.cssText, "border:1px #00000000 none;");
  });
  
  test("border = border", (){
    var a = new Style(), b = new Style();
    a.border = "1px";
    b.border = a.border;
    expect(b.cssText, "border:1px #00000000 none;");
  });


  test("font", (){
    var a = new Style(), b = new Style();
    a.fontFamily = "'A s d'";
    expect(a.cssText, "font:normal normal medium 'A s d';");
  });

  test("font2", (){
    var a = new Style(), b = new Style();
    a.font = " x-large 'A s d'";
    expect(a.cssText, "font:normal normal x-large 'A s d';");
  });
  test("padding 1", (){
    var a = new Style(), b = new Style();
    a.padding = "10px 20px";
    expect(a.cssText, "padding:10px 20px 10px 20px;");
  });
  test("padding 2", (){
    var a = new Style(), b = new Style();
    a.padding = "12px ";
    expect(a.cssText, "padding:12px;");
  });



  
}