const audioContext = new AudioContext();

const NOTE_DETAILS = [ //const having objects 
  {note: "C", key : "Z", frequency: 261.626}, //active : false
  {note: "Db", key : "S", frequency: 277.183},
  {note: "D", key : "X", frequency: 293.665},
  {note: "Eb", key : "D", frequency: 311.127},
  {note: "E", key : "C", frequency: 329.628},
  {note: "F", key : "V", frequency: 349.228},
  {note: "Gb", key : "G", frequency: 369.994},
  {note: "G", key : "B", frequency: 391.995},
  {note: "Ab", key : "H", frequency: 415.305},
  {note: "A", key : "N", frequency: 440},
  {note: "Bb", key : "J", frequency: 466.164},
  {note: "B", key : "M", frequency: 493.883}
]

function getNoteDetail(keyboardKey){
  return NOTE_DETAILS.find(n => `Key${n.key}` === keyboardKey)
}

function playNotes(){
  NOTE_DETAILS.forEach(n => {
    const keyElement = document.querySelector(`[data-note="${n.note}"]`)
    keyElement.classList.toggle("active", n.active || false)
    if(n.oscillator != null) {
      n.oscillator.stop()
      n.oscillator.disconnect()
    }
  })
  

  const activeNotes = NOTE_DETAILS.filter(n => n.active) //if active is true, return active note
  const gain = 1 / activeNotes.length
  activeNotes.forEach(n => {
    startNote(n, gain)
  })
}

function startNote(noteDetail, gain){
  const gainNode = audioContext.createGain()
  gainNode.gain.value = gain
  const oscillator = audioContext.createOscillator()
  oscillator.frequency.value = noteDetail.frequency
  oscillator.type = 'sine'
  oscillator.connect(gainNode).connect(audioContext.destination)
  oscillator.start()
  noteDetail.oscillator = oscillator // scoped from loc to glob
}

//Pressing a key down
document.addEventListener("keydown", e =>{
  if(e.repeat == true) return // garde clause, it garde from contiuning being inside your function
  // if(!e.repeat){ same as above but with code inside }

  //console.log("down")
  console.log(e)

  const keycode = e.code
  const noteDetail = getNoteDetail(keycode)

  if (noteDetail == null) return
  noteDetail.active = true
  console.log(noteDetail)

  playNotes()
})

document.addEventListener("keyup", e =>{
  const keyboardKey = e.code;
  const noteDetail = getNoteDetail(keyboardKey)

  if(noteDetail == null) return

  noteDetail.active = false
  playNotes()
  
  //console.log("up")
  //console.log(e)
})


