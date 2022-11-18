// 1.select all elements
const form = document.querySelector("#new-item-form");
const list = document.querySelector("#list");
const input = document.querySelector("#item-input");

// 2.When I submit the form add a new element

form.addEventListener("submit", e => {
  e.preventDefault();
  //console.log(input.value);

  // 1.1.Create new item
  const item = document.createElement('div')
  item.innerText = input.value;
  item.classList.add('list-item');

  console.log(item)
  // 1.2.Add that item to the list
  list.appendChild(item);
  // 1.3.Clear input
  input.value = ""
  // 1.4.Setup event listener to delete item when clicked
  item.addEventListener('click', () =>{
    //list.removeChild(item)
    item.remove();
  })
})

function test() {
  console.log("test")
}
function test2(arg1){
  console.log(arg1)
}
test("sdljfkas", 12123,312312,432243)
test2("black magic yo", 12123,312312,432243)