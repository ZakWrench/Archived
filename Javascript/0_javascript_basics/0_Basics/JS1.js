
var x;
var y;

var a = 33;
var b = 10;
var c = "test";
var linebreak = "<br/>";
var recursion = '<body> <h2>HTML Images</h2><p>HTML images are defined with the img tag:</p><img src="w3schools.jpg" alt="W3Schools.com" width="104" height="142"></body>';

document.write("a = 33 \n b = 10 \n c = \"test\" \n x = \"true\" \n y = &quot;false&quot; \n");
document.write(linebreak);


document.write("a % b = ");
result = a % b;
document.write(result);
document.write(linebreak);

document.write(" a + b + c = ");
result  = a + b + c;
document.write(result);
document.write(linebreak);

document.write(" a != b is ");
result = (a != b);
document.write(result);
document.write(linebreak);

x = true;
y = false;

document.write("!(a && b) is ");
result = (!(a && b));
document.write(result);
document.write(linebreak);

a = 2; b = 3;
document.write("((a2 > b3) ? 100 : 200) is ");
result = (a > b) ? 100 : 200;
document.write(result);
document.write(linebreak);

var c = 10;
var d = "String";

result = (typeof c == "string" ? "C is String" : "C is Numeric");
result2 = (typeof d == "string" ? "D is String" : "D is Numeric");
document.write(result, linebreak, result2, linebreak, recursion);

function fct(name,surname){
  var full;
  full = name + surname;
  return full;
}

function fct2(){
  var result;
  result = fct(1, 2);
  document.write(result)
}

function Hello(){
  alert("AAAAAAAAAA")
}

function WriteCookie(){
  if(document.myform.customer.value == ""){
    alert("Enter some value!");
    return;
  }
  cookievalue = escape(document.myform.customer.value) + ";";
  document.cookie = "name=" + cookievalue;
  document.write("setting cookies: " + "name = " + cookievalue);

}



//function ReadCookie(){
  //var allcookies = document.cookie;
  //document.write("All cookies : " + allcookies);

  //Get all the cookies pairs in an array
  //cookiearray = allcookies.split(';');

  //Now take key value pair out of this array
  //for (var i = 0; i < cookiearray.length; i++){
    //name = cookiearray[i].split('=')[0];
    //value = cookiearray[i].split('=')[1];
  //  document.write("key is : " + name " and Value is : " + value);
//  }
//}

function Redirect(){
  document.write("You will be redirected to main page in 10sec.");
   setTimeout('Redirect()', 100000);
  window.location = "https://www.google.com";
}

var browesername = navigator.appName
