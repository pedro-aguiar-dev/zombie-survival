
// If we have pressed down on this button, then released it, execute the button code in alarm[0].
if (pressed) {
	audio_play_sound(snd_loud_button_select, 0, false);
	alarm[0] = 1;
}
