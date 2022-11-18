let a = 1;
let b = 2;
let c = 3;

console.log(a)
console.log(b);
console.log(c);
//node JS2.js

console.log(typeof a);

let bool = true;
let bool2 = false;
console.log(typeof bool, typeof bool2)
console.log(bool && bool2, bool || bool2, (bool && bool2) || bool);

let und = undefined;
console.log(und, typeof und)

let noll = null;
console.log(noll, typeof noll);

console.log(a == b, a != b, a < b, a >= b, "a" == "b", "a" > "b", false == false, null == undefined);

//garbage collection

/*
comment
*/

//Normal Functions

function sayHi(){
  console.log("hi");
}
sayHi();

function sum(a,b){
  return "hello " + a + b;
}

let s = sum(1," " + "zak" + " "+ 3)
console.log(s)

//Callback Functions
function printVariable(variable){
  console.log(variable)
}

function printName(name, callback) {
  callback("callback " + name);
}

printName("Zak", printVariable);

//Arrow Functions

let sumArrow = (a,b) => {
  return a + b;
}

console.log(sumArrow(1,2))
console.log(sumArrow)

let ArrowName = (name) /*paranteses aren't required when providing just one variable "name" */ => {
  console.log(name)
}
ArrowName("zak")

//another way of doing things
let sumArrow2 = (a,b) => /*return*/ a + b;
console.log(sumArrow2(1,2))

let printHi = Hi => "Hi " + Hi;
console.log(printHi("Zak"));
//empty parameters
let hiArrow = () => {
  console.log("hi")
}
hiArrow()

//calling other functions
function func(x, callback) {
  callback(x)
}

func(10, variable => console.log(variable))

//Stack Trace And Call Stack

//Hoisting, basically when declaring functions, JS imply as if all functions
//have been declared at the top, even if they were declared at the bottom.
//But IT DOESN'T WORK WITH ARROW FUNCTIONS, since they are variables.


//Scoping

function sayHi(name2){
  let result = "Hi " + name2;
  console.log(result)
}

let name2 = "Zak";

sayHi(name2)
//This imply that parameter var name2 isnt externally declared var name2.


{
  let a2 = 10;
  {
    b = 20;
  }
}

let a2 = 10;

//Closure

function print(variable){
  let c2 = 30
  return function func2(variable2){
    console.log(variable)
    console.log(variable2)
    console.log(c)
  }
}

//print(func2(2)); //not working as expected
let a3 = print(10); //is a3 new function
a3(3)












