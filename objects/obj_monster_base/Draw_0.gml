
// Draw the monster.
draw_self();

// Draw the HP bar for the monster to the side.
draw_sprite(spr_hp, 0, 15, 110);
var _fill = hitpoints / max_hitpoints;
draw_sprite_ext(spr_hp_fill, 0, 15, 110, 1, _fill, 0, c_white, 1.0);
