//DATA ATTRIBUTES

const buttons = document.querySelectorAll('button')

buttons.forEach(buttonss => {
  buttonss.addEventListener('click', () => {
    const currentClicks = parseInt(buttonss.dataset.clicks)
    buttonss.dataset.clicks = currentClicks + 1
    console.log(buttonss.dataset.clicks) // We're basically storing data to read or write on html instead of js
  })
})
