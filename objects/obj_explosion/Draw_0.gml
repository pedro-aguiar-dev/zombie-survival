/// obj_explosion - Draw (círculo que expande e some)
if (life > 0) life -= 1;
var _t = 1 - (life / life_max);          // 0 -> 1 ao longo da vida
var _r = radius * (0.4 + 0.6 * _t);      // expande
var _a = 0.7 * (1 - _t);                 // some

draw_set_alpha(_a);
draw_set_color(c_orange);
draw_circle(x, y, _r, false);
draw_set_color(c_yellow);
draw_circle(x, y, _r * 0.6, false);

draw_set_alpha(1);
draw_set_color(c_white);
