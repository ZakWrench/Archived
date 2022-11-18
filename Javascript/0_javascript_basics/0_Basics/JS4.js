//ASYNC VS DEFER
//once we load an html page, it starts parsing from top to bottom
//when parsing files, it keeps on parsing while downloading files
//but when parsing a js files, it stops parsing until it gets js files and execute it then continue parsing

//ASYNC on the other hand, when reaching js files it parse both html and js
//once js is downloaded it start executing it, and it STOPS parsing html
//ASYNC IS BASED ON DOWNLOAD SPEED

//DEFER: html parse, js download while html parse. js finish download.
//html keeps parsing until it finishe, THEN JS is executed



//WINDOW OBJECT

console.log(window)
window.console.log(window)

window.addEventListener("resize", () => {
  console.log("resized")
})



//DOCUMENT

console.log(document) //html of the page
console.log(document.body)
console.log(document.documentElement)

const ele = document.createElement("span");
ele.innerText = "\nHello Zak 2";
document.body.appendChild(ele)
//thats basically how you interact with all the elements in your 


//ID AND CLASS SELECTORS

console.log(document.getElementById("div-id")) //<div id="div-id">
console.log(document.getElementsByClassName("div-class")) //this an html collection

const divWithId = document.getElementById("div-id")
divWithId.style.color = 'red'

const divsWithClassName = document.getElementsByClassName("div-class")
const divsWithClassArray = Array.from(divsWithClassName) //you should convert html collection to an array, from convert anything similar to an array to an array
divsWithClassArray.forEach(d => (d.style.color = 'green'))
divsWithClassArray[0].style.color = 'blue'


//QUERY SELECTORS

const dataAttributeElement = document.querySelector('[data-test]'); // css selector inside brackers
console.log(dataAttributeElement)
const dataAttributeElementAll = document.querySelectorAll('[data-test]'); // css selector inside brackers
console.log(dataAttributeElementAll)

const divsWithClass = document.querySelector(".class") //select first element
console.log(divsWithClass)
divsWithClass.style.color = "yellow";

const divsWithClassAll = document.querySelectorAll(".class")
divsWithClassAll.forEach(div => (div.style.color = "yellow"))
console.log(divsWithClassAll)

const input = document.querySelector("input"); // passing css selector
document.querySelector("input[type='text']")
document.querySelector("body > input[type='text']")

console.log(input)

//Event Listener

const btn = document.querySelector("[data-btn]")
console.log(btn)
btn.addEventListener('click', () =>{ //click is predefined, () is anonymous fct, each anonymous fct is different than the other
console.log("clicked");
let variable = 5
console.log(variable*=4)
})
btn.addEventListener('click', () =>{ //click is predefined
  console.log("clicked2");
  let variable = 5
  console.log(variable*=4)
  })

function printClick(){
  console.log("clicked3")
}

btn.addEventListener('click', printClick)
btn.removeEventListener('click', printClick)

btn.addEventListener('click', e => { // e is a conventional name for event
  console.log(e)
})

const input2 = document.querySelector('[data-input-text')

input2.addEventListener("change", () =>{
  console.log("changed")
})

input2.addEventListener("change", e =>{
  console.log("changed")
  console.log(e.target.value === "")

})

const form = document.querySelector('[data-form]');

form.addEventListener('submit', e => {
  e.preventDefault(); // added so page doesn't refresh
  console.log("submitted form")
})

const anchor = document.querySelector('[anchor-link]')
anchor.addEventListener('click', e =>{ //mouseenter,mouseleave,mouseover,focus(tab),blur(opposite of focus),resize
  e.preventDefault();
  console.log("clicked link")
})



//ADDITIONAL DIFFERENCES BETWEEN ARROW AND NORMAL FUNCTIONS

const button = document.querySelector('[data-btn2]')

button.addEventListener('click', e => {
console.log("Arrow this")
console.log(this) //this === window true
})

button.addEventListener('click', function(e){
console.log("Function this")
console.log(this) //defined based on where the function itself is called, hence button === this
console.log(e.target) //same as this
})

//this represent the scope we're inside of, which different than this in normal/arrow fcts
console.log(this === window) // same as window object




//DATA ATTRIBUTES

const dataAttribute = document.querySelector('[data-test2]')
console.log(dataAttribute.dataset) //object containing all data attributes
console.log(dataAttribute.dataset.test2)
console.log(dataAttribute.dataset.test2Two) //second keyword is in Capital

dataAttribute.dataset.test2 = "5555"
console.log(dataAttribute.dataset.test2)


































