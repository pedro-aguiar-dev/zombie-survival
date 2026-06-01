
// Draw the scene with all the heros around the table.
var _x = 940 / 2;
var _y = 80;
draw_sprite_ext(spr_spellmage,       0, _x-80,  _y+20,    -1, 1, 0, c_white, 1.0);
draw_sprite_ext(spr_fluffy,          0, _x-140, _y+25, -1, 1, 0, c_white, 1.0);
draw_sprite_ext(spr_sir_prancelot,   0, _x-200, _y+30, -1, 1, 0, c_white, 1.0);
draw_sprite_ext(spr_thokk_steelpecs, 0, _x,     _y+20,    1,  1, 0, c_white, 1.0);
draw_sprite_ext(spr_princess,        0, _x+80,  _y+20,    1,  1, 0, c_white, 1.0);
draw_sprite_ext(spr_prince,          0, _x+140, _y+25, 1,  1, 0, c_white, 1.0);
draw_sprite_ext(spr_glitterlizard,   0, _x+200, _y+30, 1,  1, 0, c_white, 1.0);
draw_sprite(spr_table, 0, _x, _y);

// Draw time taken to play to the left hand side, between the title and button.
draw_set_font(fnt_small);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var _hours = floor(date_hour_span(global.time_start, global.time_end) % 24);
var _minutes = floor(date_minute_span(global.time_start, global.time_end) % 60);
var _seconds = floor(date_second_span(global.time_start, global.time_end) % 60);
var _time_string = string_replace(string_format(_hours, 2, 0), " ", "0") + ":" +
		   string_replace(string_format(_minutes, 2, 0), " ", "0") + ":" +
		   string_replace(string_format(_seconds, 2, 0), " ", "0");

draw_text(100, 50, "Time taken:");
draw_set_color(c_ltgray);
draw_text(100, 70, _time_string);
