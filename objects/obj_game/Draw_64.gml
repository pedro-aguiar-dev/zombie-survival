var _fps = game_get_speed(gamespeed_fps);
var _gw  = display_get_gui_width();
var _gh  = display_get_gui_height();

draw_set_font(fnt_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _bx = 20, _by = 20, _bw = 240, _bh = 22;
var _frac = (player_hp_max > 0) ? clamp(player_hp / player_hp_max, 0, 1) : 0;
draw_set_color(c_black);
draw_rectangle(_bx - 2, _by - 2, _bx + _bw + 2, _by + _bh + 2, false);
draw_set_color(c_dkgray);
draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
draw_set_color(c_red);
draw_rectangle(_bx, _by, _bx + _bw * _frac, _by + _bh, false);
draw_set_color(c_white);
draw_text(_bx + 6, _by + 3, "HP " + string(max(0, player_hp)) + " / " + string(player_hp_max));

var _secs = survival_frames div _fps;
draw_text(20, 54, "Onda: "   + string(wave));
draw_text(20, 74, "Pontos: " + string(game_score));
draw_text(20, 94, "Tempo: "  + string(_secs) + "s");
draw_text(20, 114, "Tiro x" + string(global.lvl_shot) + "  Dir x" + string(global.lvl_dir)
                 + "   MG:" + (global.mode_mg ? "ON" : "--") + "   Esp:" + zs_special_name(global.mode_special));

var _bomb_txt = "PRONTA";
var _heal_txt = "PRONTA";
if (instance_exists(obj_player))
{
    if (obj_player.bomb_cd > 0) _bomb_txt = string(ceil(obj_player.bomb_cd / _fps)) + "s";
    if (obj_player.heal_cd > 0) _heal_txt = string(ceil(obj_player.heal_cd / _fps)) + "s";
}

var _ab  = zs_ability_btn_rects();
var _amx = device_mouse_x_to_gui(0);
var _amy = device_mouse_y_to_gui(0);

var _bhover = point_in_rectangle(_amx, _amy, _ab.bomb.x1, _ab.bomb.y1, _ab.bomb.x2, _ab.bomb.y2);
draw_set_color(_bhover ? c_white : c_dkgray);
draw_rectangle(_ab.bomb.x1, _ab.bomb.y1, _ab.bomb.x2, _ab.bomb.y2, true);
draw_set_color((_bomb_txt == "PRONTA") ? c_lime : c_orange);
draw_text(_ab.bomb.x1 + 6, _ab.bomb.y1 + 2, "Bomba (E): " + _bomb_txt);

var _hhover = point_in_rectangle(_amx, _amy, _ab.heal.x1, _ab.heal.y1, _ab.heal.x2, _ab.heal.y2);
draw_set_color(_hhover ? c_white : c_dkgray);
draw_rectangle(_ab.heal.x1, _ab.heal.y1, _ab.heal.x2, _ab.heal.y2, true);
draw_set_color((_heal_txt == "PRONTA") ? c_lime : c_orange);
draw_text(_ab.heal.x1 + 6, _ab.heal.y1 + 2, "Cura (Q): " + _heal_txt);
draw_set_color(c_white);

var _boss = noone;
with (obj_zombie) { if (ztype == "boss") _boss = id; }
if (_boss != noone && _boss.hp_max > 0)
{
    var _wbw = 600;
    var _wbx = (_gw - _wbw) * 0.5;
    var _wbf = clamp(_boss.hp / _boss.hp_max, 0, 1);
    draw_set_color(c_black);  draw_rectangle(_wbx - 2, 26, _wbx + _wbw + 2, 46, false);
    draw_set_color(c_dkgray); draw_rectangle(_wbx, 28, _wbx + _wbw, 44, false);
    draw_set_color(c_maroon); draw_rectangle(_wbx, 28, _wbx + _wbw * _wbf, 44, false);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_text(_gw * 0.5, 8, "B O S S");
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}

if (state == "wave_break")
{
    draw_set_halign(fa_center);
    draw_text(_gw * 0.5, _gh * 0.5 - 40, "Onda " + string(wave + 1) + " comecando...");
    draw_set_halign(fa_left);
}

if (state == "shop")
{
    var _cx = _gw * 0.5;
    var _L  = zs_shop_layout();

    draw_set_alpha(0.72);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_color(c_lime);
    draw_text(_cx, 60, "ONDA " + string(wave) + " CONCLUIDA!");
    draw_set_color(c_yellow);
    draw_text(_cx, 90, "Pontos disponiveis: " + string(global.upgrade_points));
    draw_set_color(c_aqua);
    draw_text(_cx, 118, "== LOJA  (subir de nivel fica mais caro) ==");

    var _items = zs_shop_rows();
    draw_set_halign(fa_left);

    for (var _i = 0; _i < array_length(_items); _i++)
    {
        var _u    = _items[_i];
        var _ry   = _L.y0 + _i * _L.dy;
        var _label = _u.name;
        var _tag   = "";
        var _affordable = true;
        var _owned = false;

        if (_u.kind == "stat")
        {
            var _lvl = variable_global_get(_u.key);
            _label += "  [Nv " + string(_lvl) + "/" + string(_u.maxlvl) + "]";
            if (zs_upg_ismax(_u))
            {
                _tag = "MAX";
                _affordable = false;
            }
            else
            {
                var _cost = zs_upg_cost(_u);
                _tag = string(_cost) + " pts";
                _affordable = (global.upgrade_points >= _cost);
            }
        }
        else if (_u.kind == "buy_mg")
        {
            if (global.mode_mg) { _tag = "ATIVA"; _owned = true; }
            else { _tag = string(_u.cost) + " pts"; _affordable = (global.upgrade_points >= _u.cost); }
        }
        else if (_u.kind == "buy_special")
        {
            if (global.mode_special == _u.key) { _tag = "ATIVA"; _owned = true; }
            else if (global.mode_special != "none") { _tag = "bloqueada"; _affordable = false; }
            else { _tag = string(_u.cost) + " pts"; _affordable = (global.upgrade_points >= _u.cost); }
        }

        if (_i == shop_sel)    draw_set_color(c_yellow);
        else if (_owned)       draw_set_color(c_lime);
        else if (!_affordable) draw_set_color(c_silver);
        else                   draw_set_color(c_white);

        draw_text(_L.lx,       _ry, ((_i == shop_sel) ? "> " : "  ") + _label);
        draw_text(_L.lx + 330, _ry, _tag);
    }

    var _ci  = array_length(_items);
    var _cry = _L.y0 + _ci * _L.dy + 8;
    draw_set_color((shop_sel == _ci) ? c_yellow : c_lime);
    draw_text(_L.lx, _cry, ((shop_sel == _ci) ? "> " : "  ") + ">> Continuar (proxima onda)");

    var _sry = _cry + _L.dy;
    draw_set_color((shop_sel == _ci + 1) ? c_yellow : c_orange);
    draw_text(_L.lx, _sry, ((shop_sel == _ci + 1) ? "> " : "  ") + ">> Sair (Menu)");

    draw_set_halign(fa_center);
    draw_set_color(c_gray);
    draw_text(_cx, _sry + _L.dy + 12, "Setas/Mouse: escolher    Enter/Clique: comprar, Continuar ou Sair");
    draw_set_halign(fa_left);
}

if (paused)
{
    var _cx = _gw * 0.5;

    draw_set_alpha(0.72);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_yellow);
    draw_text(_cx, _gh * 0.5 - 16, "PAUSADO");
    draw_set_color(c_gray);
    draw_text(_cx, _gh * 0.5 + 16, "Pressione ESC para continuar");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

if (state == "gameover")
{
    var _cx = _gw * 0.5;

    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_color(c_red);
    draw_text(_cx, _gh * 0.5 - 150, "GAME OVER");

    draw_set_color(c_white);
    draw_text(_cx, _gh * 0.5 - 110, "Onda alcancada: "   + string(wave));
    draw_text(_cx, _gh * 0.5 - 90,  "Pontuacao: "        + string(game_score));
    draw_text(_cx, _gh * 0.5 - 70,  "Tempo: "            + string(_secs) + "s");
    draw_text(_cx, _gh * 0.5 - 50,  "Partidas jogadas: " + string(global.games_played));

    draw_set_color(c_orange);
    draw_text(_cx, _gh * 0.5 - 14, "Suas habilidades foram resetadas.");

    var _btns = zs_gameover_btn_rects();
    var _hr = point_in_rectangle(_amx, _amy, _btns.restart.x1, _btns.restart.y1, _btns.restart.x2, _btns.restart.y2);
    var _hm = point_in_rectangle(_amx, _amy, _btns.menu.x1,    _btns.menu.y1,    _btns.menu.x2,    _btns.menu.y2);

    draw_set_valign(fa_middle);
    draw_set_color(_hr ? c_olive : c_dkgray);
    draw_rectangle(_btns.restart.x1, _btns.restart.y1, _btns.restart.x2, _btns.restart.y2, false);
    draw_set_color(_hr ? c_yellow : c_white);
    draw_rectangle(_btns.restart.x1, _btns.restart.y1, _btns.restart.x2, _btns.restart.y2, true);
    draw_text((_btns.restart.x1 + _btns.restart.x2) * 0.5, (_btns.restart.y1 + _btns.restart.y2) * 0.5, "Reiniciar (R)");

    draw_set_color(_hm ? c_olive : c_dkgray);
    draw_rectangle(_btns.menu.x1, _btns.menu.y1, _btns.menu.x2, _btns.menu.y2, false);
    draw_set_color(_hm ? c_yellow : c_white);
    draw_rectangle(_btns.menu.x1, _btns.menu.y1, _btns.menu.x2, _btns.menu.y2, true);
    draw_text((_btns.menu.x1 + _btns.menu.x2) * 0.5, (_btns.menu.y1 + _btns.menu.y2) * 0.5, "Menu (M)");

    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}

draw_set_color(c_white);
draw_set_alpha(1);
