//CALLBACKS

setTimeout(() =>{
  console.log("inside")
}, 1000) //asynchronous

console.log("outside") //synchronous


const button = document.querySelector("#button1")
const button2 = document.querySelector("#button2")

button.addEventListener("click", () => { //asynchronous
  console.log("clicked")
})
addClickEventListener(button2, () => { //same as previous event
  console.log("clicked")
})

//callbacks is a function that you pass to another function in order
//to be executed at a later time based on a certain specific condition

function addClickEventListener(element, callback){
  element.addEventListener("click", callback)
  // same as ("click", () => { callback() })

}

setTimeout(() =>{ //callback hell
  console.log("inside1")
  setTimeout(() => {
    console.log("inside2")
    setTimeout(() => {
      console.log("inside3")
    },300)
  }, 500)
}, 1) 

