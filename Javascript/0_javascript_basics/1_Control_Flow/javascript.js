// IF| ELSE IF | ELSE

const zero = 0;
let welcomeMessage = "";

if(zero === null || zero === undefined){
  console.log("zero");
} else if (zero){}
  else if (zero){}
 else {
  console.log("not zero") 
  welcomeMessage = "// because zero gets converted to false, same as empty string"
}
console.log(welcomeMessage)


const array = [1,2,3,4,5,6,7,8,8]

if(array.length === 0){
  console.log("empty array");
} else if(array.length < 5){
  console.log("small");
} else if(array.length < 10){
  console.log("count: %d", array.length)
} else {
  console.log("large")
}



//TERNARY OPERATIONS

if(array === array) console.log("same line")

array === array ? console.log("same line again") : console.log("not working on same line");

welcomeMessage = array === array ? "welcome" : "not welcome";
console.log(welcomeMessage)




//SWITCH STATEMENT

const favoriteAnimal = "dog";
function cat(cat) {
  console.log("cat")
}

switch(favoriteAnimal) {
  case "dog":
    console.log("dog")
    break;
  case "cow":
    console.log("cow");
    break;
  case "cat" :
    cat()
    break;
  default:
    console.log("none of the above")
}

const number = 1;

switch(number){
  case 0 :
    console.log("0")
    break;
  case 1 || 2:
    console.log("1 or 2")
    break;
  case 3:
  case 4:
    console.log("3 or 4")
    break;
  default:
    console.log("try again")
}



// FOR LOOP

for (let i = 0; i <= 5; i = i + 2){
  console.log("hi")
}

for (let i = 0; i <= 20; i = i + 2){
  console.log("start %d", i)
  if (i > 6) break;
  console.log("hi %d", i)
}

//legacy
for (let i = 0; i < array.length; i++){
  const element = array[i];
  console.log(element)
}
//modern
array.forEach(element => console.log(element))




//WHILE LOOP
//when you don't know how much you're gonna loop through



const person = {
  name:'Kyle',
  friend: {
    name: 'Joe',
    friend: {
      name: 'Sally'
    }
  }
}

const persons = {
  name:'Kyle',
  friend: {
    name: 'Joe',
    friend: {
      name: 'Sally'
    }
  }
}

let currentPerson = person
console.log(JSON.stringify(currentPerson) + "outer scope")
while(currentPerson.friend != null){
  console.log(currentPerson.name)
  currentPerson = currentPerson.friend
}
console.log(JSON.stringify(currentPerson) + "outer scope")

currentPerson = persons
while(currentPerson != null){
  if(currentPerson.name === "Joe") break;
  console.log(currentPerson.name + " eh")
  currentPerson = currentPerson.friend
}



//RECURSION
//looping with function with or without return

function recursion(){
  recursion();
}

//recursion()

for (let i = 1; i <= 10; i++){
  console.log(i)
}

function printNumber(number){
  if (number > 2) return number
  console.log(number)
  printNumber(number + 1)
  console.log("exiting function")
}

printNumber(1)
console.log("end")

let sum = 0;
for(let i = 1; i <= 10; i++){
  sum = sum + i
}

console.log(sum)

function sumNumbersBelow(number){
  if (number <= -2) return false
  console.log(number)
  return number + sumNumbersBelow(number - 1)
}

console.log(sumNumbersBelow(10))

function names(x){
  if (x == null) return 0;
  console.log(x.name);
  return names(x.friend)
}

names(person)




//! SHORT CIRCUIT EVALUATION
// true || false ignores second evaluation

printTrue() || printFalse()
console.log("")
printFalse() || printTrue()

function printTrue(){
  console.log("true")
  return true;
}
function printFalse(){
  console.log("false")
  return false
}

function printName(name){
  if (name == null){
    name = "Default"
  }
  console.log(name)
}
printName("Zak")
//same as
function printName2(name){
  name = name || "Default"
  console.log(name)
  console.log(name || "default") //this is true because it already have the value "Default"
}
printName2()

const human = {
  name:"Zak",
  //address: {
    //street: "Main St"
  //}
}

if (human != null && human.address != null){
  console.log(human.address.street)
}
//same as
console.log(human && human.address && human.address.street)





//



















