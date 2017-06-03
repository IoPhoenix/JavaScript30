<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="description" content="JavaScript 30 day Challenge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>JavsScript 30: Drum Kit</title>
	<link href="custom.css" rel="stylesheet">
</head>


<body>
	  <div class="keys">
      <div data-key="65" class="key"> <!-- data-key - numbers associated with the keybord key -->
        <kbd>A</kbd> <!-- <kbd> - keyboard key -->
        <span class="sound">clap</span>
      </div>
      <div data-key="83" class="key">
        <kbd>S</kbd>
        <span class="sound">hihat</span>
      </div>
      <div data-key="68" class="key">
        <kbd>D</kbd>
        <span class="sound">kick</span>
      </div>
      <div data-key="70" class="key">
        <kbd>F</kbd>
        <span class="sound">openhat</span>
      </div>
      <div data-key="71" class="key">
        <kbd>G</kbd>
        <span class="sound">boom</span>
      </div>
      <div data-key="72" class="key">
        <kbd>H</kbd>
        <span class="sound">ride</span>
      </div>
      <div data-key="74" class="key">
        <kbd>J</kbd>
        <span class="sound">snare</span>
      </div>
      <div data-key="75" class="key">
        <kbd>K</kbd>
        <span class="sound">tom</span>
      </div>
      <div data-key="76" class="key">
        <kbd>L</kbd>
        <span class="sound">tink</span>
      </div>
  </div>

  <audio data-key="65" src="sounds/clap.wav"></audio>
  <audio data-key="83" src="sounds/hihat.wav"></audio>
  <audio data-key="68" src="sounds/kick.wav"></audio>
  <audio data-key="70" src="sounds/openhat.wav"></audio>
  <audio data-key="71" src="sounds/boom.wav"></audio>
  <audio data-key="72" src="sounds/ride.wav"></audio>
  <audio data-key="74" src="sounds/snare.wav"></audio>
  <audio data-key="75" src="sounds/tom.wav"></audio>
  <audio data-key="76" src="sounds/tink.wav"></audio>

<script>
  function playSound(e) {
    const audio = document.querySelector(`audio[data-key="${e.keyCode}"]`);  // ${e.keyCode}" - ES6 template string
    const key = document.querySelector(`.key[data-key="${e.keyCode}"]`);

    if(!audio) return; // stop function from running 
    audio.currentTime = 0; // rewind to the start
    audio.play();
    key.classList.add('playing'); // addClass in jQuery
  }

 function removeTransition(e) {
    if(e.propertyName !== 'transform') return; // skip if it's not a transform
    this.classList.remove('playing'); //this ==== e.srcElement
  }

  const keys = document.querySelectorAll('.key');
  keys.forEach(key => key.addEventListener('transitionend', removeTransition));
  window.addEventListener('keydown', playSound);
</script>

</body>
</html>

