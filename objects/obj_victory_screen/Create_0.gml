
// Get the current datetime when this object is create.
// This value, minus global.time_start (which we get when starting the main room), is our total play time.
global.time_end = date_current_datetime();
audio_play_sound(snd_victory, 0, false);
