/// obj_menu - Draw GUI
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();
var _cx = _gw * 0.5;

draw_set_font(fnt_small);
draw_set_valign(fa_top);

// Fundo
draw_set_color(c_black);
draw_rectangle(0, 0, _gw, _gh, false);

// Título
draw_set_halign(fa_center);
draw_set_color(c_lime);
draw_text(_cx, _gh * 0.22, "ZOMBIE SURVIVAL 2D");
draw_set_color(c_gray);
draw_text(_cx, _gh * 0.22 + 24, "Sobreviva as hordas de zumbis!");

// Itens do menu
var _y0 = _gh * 0.45;
var _dy = 34;

var _vol_geral = string(round(global.master_volume * 100)) + "%";
var _vol_sfx   = string(round(global.sfx_volume    * 100)) + "%";

var _labels = [
    "Jogar",
    "Volume Geral:  < " + _vol_geral + " >",
    "Volume SFX:    < " + _vol_sfx   + " >",
    "Sair",
];

for (var _i = 0; _i < array_length(_labels); _i++)
{
    if (_i == sel) draw_set_color(c_yellow);
    else           draw_set_color(c_white);

    var _txt = (_i == sel ? "> " : "  ") + _labels[_i];
    draw_text(_cx, _y0 + _i * _dy, _txt);
}

// Dicas
draw_set_color(c_gray);
draw_text(_cx, _gh * 0.85, "Setas/Mouse: navegar e ajustar    Enter/Clique: confirmar");
draw_text(_cx, _gh * 0.85 + 20, "Partidas jogadas: " + string(global.games_played));

draw_set_halign(fa_left);
draw_set_color(c_white);
