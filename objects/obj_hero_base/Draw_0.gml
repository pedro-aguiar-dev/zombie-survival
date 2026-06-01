
// If this hero is unlocked, draw the hero...
// Otherwise, draw the plus symbol in it's place.
if (unlocked) {
	draw_self();
} else {
	draw_sprite(spr_plus_icon, 0, x, y);
}
