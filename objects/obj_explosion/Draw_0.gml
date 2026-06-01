if (life > 0) life -= 1;
var _t = 1 - (life / life_max);
var _r = radius * (0.4 + 0.6 * _t);
var _a = 0.7 * (1 - _t);

draw_set_alpha(_a);
draw_set_color(c_orange);
draw_circle(x, y, _r, false);
draw_set_color(c_yellow);
draw_circle(x, y, _r * 0.6, false);

draw_set_alpha(1);
draw_set_color(c_white);
