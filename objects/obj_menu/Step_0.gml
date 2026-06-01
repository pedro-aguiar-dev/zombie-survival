/// obj_menu - Step (navegação por teclado + mouse)

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _click = mouse_check_button_pressed(mb_left);
var _moved = (_mx != prev_mx) || (_my != prev_my);
prev_mx = _mx;
prev_my = _my;

// Layout das linhas (igual ao Draw GUI)
var _cx = display_get_gui_width()  * 0.5;
var _y0 = display_get_gui_height() * 0.45;
var _dy = 34;

// Hover do mouse sobre as linhas
var _hover = -1;
for (var _i = 0; _i < menu_count; _i++)
{
    var _ry = _y0 + _i * _dy;
    if (_mx >= _cx - 220 && _mx <= _cx + 220 && _my >= _ry - 4 && _my <= _ry + 22) _hover = _i;
}
if (_hover != -1 && _moved) sel = _hover;

// Navegação por teclado
if (keyboard_check_pressed(vk_up))   sel = (sel - 1 + menu_count) mod menu_count;
if (keyboard_check_pressed(vk_down)) sel = (sel + 1) mod menu_count;

var _left    = keyboard_check_pressed(vk_left);
var _right   = keyboard_check_pressed(vk_right);
var _confirm = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

var _click_here = (_hover != -1 && _click);
if (_click_here) sel = _hover;

switch (sel)
{
    case 0: // Jogar
        if (_confirm || _click_here) room_goto(rm_game);
    break;

    case 1: // Volume Geral (setas; ou clicar na metade esquerda/direita da linha)
        var _dec = _left  || (_click_here && _mx <  _cx);
        var _inc = _right || (_click_here && _mx >= _cx);
        if (_dec) global.master_volume = clamp(global.master_volume - 0.1, 0, 1);
        if (_inc) global.master_volume = clamp(global.master_volume + 0.1, 0, 1);
        if (_dec || _inc) audio_master_gain(global.master_volume);
    break;

    case 2: // Volume SFX
        var _dec2 = _left  || (_click_here && _mx <  _cx);
        var _inc2 = _right || (_click_here && _mx >= _cx);
        if (_dec2) global.sfx_volume = clamp(global.sfx_volume - 0.1, 0, 1);
        if (_inc2) global.sfx_volume = clamp(global.sfx_volume + 0.1, 0, 1);
        if (_dec2 || _inc2) audio_play_sound(snd_zs_shoot, 1, false, global.sfx_volume); // prévia
    break;

    case 3: // Sair
        if (_confirm || _click_here) game_end();
    break;
}
