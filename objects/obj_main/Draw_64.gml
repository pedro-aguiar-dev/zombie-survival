
// Draw the total number of coins we currently have in the top right.
draw_sprite(spr_coin_counter, 0, 940 - 80, 1);
draw_set_font(fnt_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(#f1ba45);
draw_text(880, 3, global.gold);
