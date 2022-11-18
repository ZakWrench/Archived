 //CONST
 
 const a = 1;

  console.log(a);

//TYPE COERCION (CONVERSION)
let a2 = "1"
let b = "2";
let c = 3.14;
let d = null;
let e = undefined;
let f = "Zak"

console.log(typeof parseInt(b));
console.log(parseFloat(b));
console.log(c.toString()+" is a string now after type coercion")
//implicit conversion (minus convert to numbers, plus convert to string)
console.log(b-a);




// == VS ===, === doesn't convert the type
console.log(a === a2);
console.log(d === e);
console.log(a !== a2);



// NaN
console.log(parseInt(f))
console.log(parseInt(f) === NaN)
console.log(isNaN(parseInt(f)))



//ARRAYS
const array = [1,2,3,4];
console.log(array);
console.log(array[0]);
//add element to array
array.push(5);
array.push("Zak");
//add nested array
array.push(["Zak2", 6]);
console.log(array);

//first dimension for which array, second dimension for which index
const array2 = [[1,2],[3,4,5]];
console.log(array2)
console.log(array2[1][2]);

const ex = ["a", "b", "c", "d", "e"]
console.log(ex[2])

const ex2 = [
[1,2,3,4,5],
[6,7,8,9,10],
[11,12,13,14,15]
]
console.log(ex2[0][3],ex2[1][2],ex2[2][0]);

//length
console.log(ex2.length) //length of the superarray
console.log(ex2[0].length) //length of subarrays



//OBJECTS

let personExample = {} //empty object
//key and value
const person = {
name: "Zak", 
age : 24, 
favoriteNumber: 8, //name is key, "Zak" is the value
sayHi: function() { //anonymous function
  console.log("hi");
},
sayHi2(){
  console.log("hi");
}
}

console.log(person, person.name, person.favoriteNumber)
person.sayHi2();

const car = {
  Make:"Nissan",
  Model: "400Z",
  isUsed: false,
  makeNoise(){
    console.log("Vroom");
  },
  Accelerate(){}
}

car.makeNoise()
console.log(car.Model)
//console.log(car["Make"])

//Objects inside Objects

const person2 = {
  name:"Zak",
  hobbies: ["Skateboarding", "Scuba Diving"],
  address:{
    street:'12345 Main St',
    city:"Somewhere"
  },
  planet:"Cepheus"
}

console.log(person2.address.city, person2.hobbies[0]);

const book = {
  title: "The ways of Shadows",
  author:{
    name:"Someone with a cool name",
    age:35
  }
}

book.title = "The way of Lights"
console.log(book.title)



//REFERENCE VS VALUE

let a10 = 10;
let b10 = "Hi";
let c10 = [1,2]
let d10 = c10;
d10.push(3)
console.log("c = " + c10) //converted to an array, and both c10 and d10 point to the same memory address
console.log("title = " + JSON.stringify(book.title))//JSON is an object, stringify is a function inside JSON object

let arr = [1,2];
let arr2 = [1,2];
console.log(arr === arr2);

const a8 = { name: "Zal", age: 24}

//a8 = { name : "Zak"} doesn't work because thanks to reference a8 is a constant because of memory address

arr3 = [1,2];
const elementToAdd = 3;

add(arr3, elementToAdd);

console.log(arr3)
console.log(elementToAdd)

function add(array, element){
  element = element + 1
  array.push(element)
}



//ARRAY METHODS

const arr4 = [1,2,3,4,5];

arr4.forEach((number,index,) =>{
  console.log(number + " " + index)
})

const newArr = arr4.map(number =>{
  return number * 2;
})
console.log(newArr)

const newArr2 = arr2.filter(number => {
  return number <= 2;
})
console.log(newArr2)

const Find  = arr4.find(number => {
  return number > 2;
})
console.log(Find)

const isTrue = arr4.some(number =>{
  return number > 8
})
console.log(isTrue)

const isEveryTrue = arr4.every(number =>{
  return number > 0
})
console.log(isEveryTrue)

const arraySum = arr4.reduce((sum, number) =>{
  return sum + number;
}, 0)
console.log(arraySum)

const items = [
  {price:10},
  {price:20},
  {price:30},
  {price:4}
];

const ArraySum2 = items.reduce((sum, number) =>{
  return sum + number.price;
},0)
console.log(ArraySum2)

const doesItInclude = arr4.includes(6);
console.log(doesItInclude);



//STRING TEMPLATE LITERALS

let hello = "Hello";
let world = "world";
console.log(hello + " " + world)
console.log(`${hello} ${world} ${2+3} ${car.Model} ${arr4[2]}`);

let zak = "Zak"
console.log(`${zak}'s car is ${car.Model}`)



//NEW AND THIS <---

function createUser(name, age){
  return { name: name, age:age, human:true} // returning new objects
}
const user = createUser("Zak", 24)
console.log(user)

const date = new Date();
console.log(date.getMonth() + 1);
// when creating an object with new keyword it's called a constructor
//use Capital Letter when creating Constructor

function UserThis(name, age){
  //this = {}
  this.name = name;
  this.age = age;
  this.human = true;
  //return this
}

const user2 = new UserThis("Zak", 24);
console.log(user2,"\n" + user2.name);

class ClassUser {
  constructor(name, age){
    this.name = name;
    this.age = age;
    this.human = true;
  }

  printName(){
    console.log(this.name)
  }
}
const user3 = new ClassUser("Zak", 24);
const user4 = new ClassUser("Fatihi", 1);
user3.printName();
user4.printName();


















