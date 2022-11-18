const form = document.querySelector("#form")
const usernameInput = document.querySelector("#username")
const passwordInput = document.querySelector("#password")
const passwordConfirmInput = document.querySelector("#password-confirmation")
const termsInput = document.querySelector("#terms")
const errorsContainer = document.querySelector(".errors")
const errorsList = document.querySelector(".errors-list")

form.addEventListener('submit', e =>{
  const errorMessages =[]
  //e.preventDefault() //delete afterward
  clearErrors()

  if(usernameInput.value.length < 6){
    errorMessages.push("Username must be at least 6 characters")
  }
  if(passwordInput.value.length < 10){
    errorMessages.push("Password must be at least 10 characters")
  }
  if(passwordConfirmInput.value !== passwordInput.value){
    errorMessages.push("Password must match")
  }
  if(!termsInput.checked){
    errorMessages.push("You must accept TOS")
  }
  if(errorMessages.length > 0){
    e.preventDefault()
    showErrors(errorMessages)
  }
  console.log(errorMessages)
})

function clearErrors() {
//errorList.innerHTML = ""
  while(errorsList.children[0] != null){
    errorsList.removeChild(errorsList.children[0])
    }
  errorsContainer.classList.remove("show") //remove the show
}

function showErrors(errorMessages) {
  errorMessages.forEach(errorMessage => {
    const li = document.createElement("li")
    li.innerText = errorMessage
    errorsList.appendChild(li)
  })
  errorsContainer.classList.add("show")
}
