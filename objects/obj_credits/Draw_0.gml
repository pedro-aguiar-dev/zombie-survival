
// Draw self, this is the panel sprite.
draw_self();

// Draw title/header.
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_small);
draw_text(x, y - 60, "CREDITS");

// Draw font attribution.
draw_set_font(fnt_small);
draw_text(x, y - 18, @"Victory SFX:
Jon K. Fite");
