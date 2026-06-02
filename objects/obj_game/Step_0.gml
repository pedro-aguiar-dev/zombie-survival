var _fps = game_get_speed(gamespeed_fps);

if (instance_exists(obj_player))
{
    player_hp     = obj_player.hp;
    player_hp_max = obj_player.hp_max;
}

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _click = mouse_check_button_pressed(mb_left);
var _moved = (_mx != prev_mx) || (_my != prev_my);
prev_mx = _mx;
prev_my = _my;

switch (state)
{
    case "playing":
        survival_frames += 1;

        if (to_spawn > 0)
        {
            if (spawn_cd > 0) spawn_cd -= 1;
            else
            {
                zs_spawn_zombie(zs_pick_zombie_type(wave));
                to_spawn -= 1;
                spawn_cd = spawn_cd_max;
            }
        }

        if (to_spawn <= 0 && instance_number(obj_zombie) == 0)
        {
            state = "shop";
            shop_sel = 0;
        }
    break;

    case "shop":
        var _items = zs_shop_rows();
        var _continue_idx = array_length(_items);
        var _exit_idx = _continue_idx + 1;
        var _total = _continue_idx + 2;

        if (keyboard_check_pressed(vk_up))   shop_sel = (shop_sel - 1 + _total) mod _total;
        if (keyboard_check_pressed(vk_down)) shop_sel = (shop_sel + 1) mod _total;

        var _hover = zs_shop_hover(_mx, _my, _continue_idx, true);
        if (_hover != -1 && _moved) shop_sel = _hover;
        var _click_row = (_hover != -1 && _click);
        if (_click_row) shop_sel = _hover;

        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || _click_row)
        {
            if (shop_sel == _continue_idx)
            {
                state = "wave_break";
                break_timer = round(1.0 * _fps);
            }
            else if (shop_sel == _exit_idx)
            {
                room_goto(rm_menu);
            }
            else
            {
                zs_shop_activate(_items[shop_sel]);
            }
        }
    break;

    case "wave_break":
        if (break_timer > 0) break_timer -= 1;
        else
        {
            wave += 1;
            to_spawn = 4 + wave * 2;
            spawn_cd = 0;

            if (wave mod 10 == 0) zs_spawn_zombie("boss");

            state = "playing";
        }
    break;

    case "gameover":

        var _btns = zs_gameover_btn_rects();
        var _hit_restart = point_in_rectangle(_mx, _my, _btns.restart.x1, _btns.restart.y1, _btns.restart.x2, _btns.restart.y2);
        var _hit_menu    = point_in_rectangle(_mx, _my, _btns.menu.x1,    _btns.menu.y1,    _btns.menu.x2,    _btns.menu.y2);

        if (keyboard_check_pressed(ord("R")) || (_hit_restart && _click)) room_restart();
        if (keyboard_check_pressed(ord("M")) || (_hit_menu    && _click)) room_goto(rm_menu);
    break;
}
