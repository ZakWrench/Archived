const modal = document.querySelector("#modal")
const openModal = document.querySelector("#open-modal-btn")
const closeModal = document.querySelector("#close-modal-btn")
const overlay = document.querySelector("#overlay")

// create a click event listener for the open-modal-btn that adds the class "open" to the modal
// Also add the class "open" to the overlay

openModal.addEventListener("click", e =>{
  modal.classList.add("open") // adding the class open to the modal wit classList
  overlay.classList.add("open")
})

// Create a click event listener for the close-modal-btn that removes the class "open" from the modal
// Also remove the class "open" from the overlay

closeModal.addEventListener("click", e =>{
  closeModalFct();
})

//Add a click event listener to the overlay that removes the class "open" from the modal and the overlay

overlay.addEventListener("click", closeModalFct) //same as passing inside 

function closeModalFct(){
  modal.classList.remove("open")
  overlay.classList.remove("open")
}