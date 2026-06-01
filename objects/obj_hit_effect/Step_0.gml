
// If the coin is falling, and hits the bottom of the screen...
// Then make it bounce.
if (y >= 120 && vspeed > 0) {
	vspeed = -vspeed * 0.9;
}
