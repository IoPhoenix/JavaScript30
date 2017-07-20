
let countdown;
const timerDisplay = document.querySelector('.display__time-left');
const endTime = document.querySelector('.display__end-time');
const buttons = document.querySelectorAll('[data-time]');

function timer(seconds) {
    // buggy version:
    // setTimeout(function() {
    //    seconds--;
    // }, 1000);


    // clear any existing timers
    clearInterval(countdown);


    // when timer started
    const now = Date.now(); // same as new Date().getTime();

    // when it stops
    const then = now + seconds * 1000;
    displayTimeLeft(seconds);
    displayEndTime(then);

    // how much time left on the clock
    countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        // check if we should stop it
        if (secondsLeft < 0) {
            clearInterval(countdown);
            return;
        }

        // display it
        displayTimeLeft(secondsLeft);
    }, 1000);
}

// we need this function to start count down immediately
// cause setInterval starts after 1 sec
function displayTimeLeft(seconds) {
    const mins = Math.floor(seconds / 60);
    const remainderSeconds = seconds % 60;
    const display = `${mins}:${remainderSeconds < 10 ? '0' : '' }${remainderSeconds}`;

    //update tab title
    document.title = display;
    timerDisplay.textContent = display;
}

function displayEndTime(timestamp) {
    const end = new Date(timestamp); // == new Date(Date.now());
    const hour = end.getHours();
    const minutes = end.getMinutes();
    endTime.textContent = `Be back at ${hour > 12 ? hour - 12 : hour}:${minutes < 10 ? '0' : ''}${minutes}`;
}

function startTimer() {
    const seconds = parseInt(this.dataset.time);
    timer(seconds);
}

buttons.forEach(button => button.addEventListener('click', startTimer));

// select form by name directly
document.customForm.addEventListener('submit', function(e) {
    e.preventDefault();
    const mins = this.minutes.value;
    timer(mins * 60);
    this.reset();
});