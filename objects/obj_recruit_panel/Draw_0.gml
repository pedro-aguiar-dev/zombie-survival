draw_self();

draw_sprite(spr_hero_info, 0, x + 104, y + 9);

var _hired = target.unlocked;
var _can_afford = _hired || (global.gold >= target.cost);
draw_sprite(target.locked_sprite, _can_afford, x + 117, y + 15);
if (_hired)
	draw_sprite(spr_hired_banner, 0, x + 117, y + 37);

draw_sprite(spr_arrow_frame, 0, x + 448, y + 60);

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(x + 280, y + 14, target.name);

draw_set_halign(fa_left);
draw_set_color(c_gray);
draw_text(x + 200, y + 35, target.slogan);

draw_sprite(spr_coin_small, 0, x + 365, y + 22);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(x + 375, y + 15, target.cost);

draw_set_halign(fa_right);
draw_set_color(#ff6b80);
draw_text(x + 334, y + 70, target.click_bonus);
draw_text(x + 334, y + 88, target.damage);
