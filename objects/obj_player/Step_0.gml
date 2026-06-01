var _mx = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _my = keyboard_check(ord("S")) - keyboard_check(ord("W"));
if (_mx != 0 || _my != 0)
{
    var _len = sqrt(_mx * _mx + _my * _my);
    x += (_mx / _len) * move_speed;
    y += (_my / _len) * move_speed;
}

x = clamp(x, arena_margin, room_width  - arena_margin);
y = clamp(y, arena_margin, room_height - arena_margin);

if (fire_cd > 0) fire_cd -= 1;
var _target = instance_nearest(x, y, obj_zombie);
if (fire_cd <= 0 && instance_exists(_target))
{
    var _dir = point_direction(x, y, _target.x, _target.y);
    last_aim_dir = _dir;
    fire_cd = zs_player_fire(_dir);
    audio_play_sound(snd_zs_shoot, 1, false, global.sfx_volume);
}

if (global.mode_special == "bazooka")
{
    if (bazooka_cd > 0) bazooka_cd -= 1;
    else if (instance_exists(_target))
    {
        var _bd = point_direction(x, y, _target.x, _target.y);
        zs_make_bullet(x, y, _bd, 6, damage * 3, "rocket", 90, 0);
        audio_play_sound(snd_zs_shoot, 1, false, global.sfx_volume);
        bazooka_cd = 60;
    }
}
else if (global.mode_special == "grenade")
{
    if (grenade_cd > 0) grenade_cd -= 1;
    else if (instance_exists(_target))
    {
        var _gd = point_direction(x, y, _target.x, _target.y);
        var _fz = round(game_get_speed(gamespeed_fps) * 0.7);
        zs_make_bullet(x, y, _gd, 7, damage * 2, "grenade", 70, _fz);
        audio_play_sound(snd_zs_shoot, 1, false, global.sfx_volume);
        grenade_cd = 72;
    }
}

var _ab      = zs_ability_btn_rects();
var _amx     = device_mouse_x_to_gui(0);
var _amy     = device_mouse_y_to_gui(0);
var _aclick  = mouse_check_button_pressed(mb_left);
var _playing = (instance_exists(obj_game) && obj_game.state == "playing");
var _bomb_btn = _playing && _aclick && point_in_rectangle(_amx, _amy, _ab.bomb.x1, _ab.bomb.y1, _ab.bomb.x2, _ab.bomb.y2);
var _heal_btn = _playing && _aclick && point_in_rectangle(_amx, _amy, _ab.heal.x1, _ab.heal.y1, _ab.heal.x2, _ab.heal.y2);

if (bomb_cd > 0) bomb_cd -= 1;
if ((keyboard_check_pressed(ord("E")) || _bomb_btn) && bomb_cd <= 0)
{
    zs_explode(x, y, bomb_radius, 9999);
    bomb_cd = bomb_cd_max;
}

if (heal_cd > 0) heal_cd -= 1;
if ((keyboard_check_pressed(ord("Q")) || _heal_btn) && heal_cd <= 0)
{
    hp = min(hp + heal_amount, hp_max);
    heal_cd = heal_cd_max;
}

if (hp < prev_hp) hurt_timer = 12;
prev_hp = hp;
if (hurt_timer > 0)
{
    hurt_timer -= 1;
    image_blend = (hurt_timer mod 4 < 2) ? c_red : c_white;
}
else
{
    image_blend = c_white;
}

if (hp <= 0)
{
    with (obj_game)
    {
        if (state != "gameover")
        {
            state = "gameover";
            shop_sel = 0;
            zs_reset_build();
        }
    }
    instance_destroy();
}
