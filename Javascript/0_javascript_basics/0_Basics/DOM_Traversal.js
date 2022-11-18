const grandParent = document.querySelector("#grand-parent");
const parentOne = grandParent.children[0]
const parentTwo = parentOne.nextElementSibling //previousElementSibling
const childTwo = parentOne.children[1]
const childOne = childTwo.previousElementSibling

grandParent.style.color = "red"
parentTwo.style.color = "green"
parentOne.style.color = "blue"
childOne.style.color = "yellow"
childTwo.style.color = "grey"

console.log(grandParent.children)
//////
const child = document.querySelector("#child-one")
const parent = child.parentElement
parent.style.color = "black"
const grandParent2 = parent.parentElement
grandParent2.style.color = "blue"

const childOne2 = document.querySelector("#child-one2")
const grandParent3 = childOne2.closest(".grand-parent")
grandParent3.style.color = "green"


///////
const grandParent4 = document.querySelector("#grand-parent2")
const children4 = grandParent4.querySelectorAll(".child")
const parent4 = grandParent4.querySelector(".red")
parent4.style.color = "pink"
children4.forEach(child => (child.style.color = "blue"))