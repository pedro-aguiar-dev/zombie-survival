function zs_reset_build()
{

    global.up_damage   = 0;
    global.up_speed    = 0;
    global.up_firerate = 0;
    global.up_maxhp    = 0;
    global.lvl_shot    = 1;
    global.lvl_dir     = 1;

    global.mode_mg      = false;
    global.mode_special = "none";

    global.upgrade_points = 0;
}

function zs_init_globals()
{
    if (variable_global_exists("zs_initialized")) return;
    global.zs_initialized = true;

    global.games_played  = 0;
    global.master_volume = 1;
    global.sfx_volume    = 1;

    zs_reset_build();
}

function zs_shop_rows()
{
    return [
        { kind: "stat", key: "lvl_shot",    name: "Tiro (balas/direcao)", base: 30, minlvl: 1, maxlvl: 5 },
        { kind: "stat", key: "lvl_dir",     name: "Direcoes de tiro",     base: 40, minlvl: 1, maxlvl: 5 },
        { kind: "stat", key: "up_firerate", name: "Cadencia",             base: 30, minlvl: 0, maxlvl: 5 },
        { kind: "stat", key: "up_damage",   name: "Dano",                 base: 30, minlvl: 0, maxlvl: 5 },
        { kind: "stat", key: "up_speed",    name: "Velocidade",           base: 30, minlvl: 0, maxlvl: 5 },
        { kind: "stat", key: "up_maxhp",    name: "Vida Maxima",          base: 30, minlvl: 0, maxlvl: 5 },
        { kind: "buy_mg",      name: "Metralhadora",   cost: 120 },
        { kind: "buy_special", key: "bazooka", name: "Bazuca",        cost: 150 },
        { kind: "buy_special", key: "grenade", name: "Lanca-Granada", cost: 150 },
    ];
}

function zs_upg_cost(_u)
{
    var _steps = variable_global_get(_u.key) - _u.minlvl;
    return _u.base * (_steps + 1);
}

function zs_upg_ismax(_u)
{
    return variable_global_get(_u.key) >= _u.maxlvl;
}

function zs_special_name(_s)
{
    if (_s == "bazooka") return "Bazuca";
    if (_s == "grenade") return "Lanca-Granada";
    return "Nenhum";
}

function zs_shop_buy(_u)
{
    if (zs_upg_ismax(_u)) return;
    var _cost = zs_upg_cost(_u);
    if (global.upgrade_points >= _cost)
    {
        global.upgrade_points -= _cost;
        variable_global_set(_u.key, variable_global_get(_u.key) + 1);
    }
}

function zs_shop_activate(_row)
{
    switch (_row.kind)
    {
        case "stat":
            zs_shop_buy(_row);
        break;

        case "buy_mg":

            if (!global.mode_mg && global.upgrade_points >= _row.cost)
            {
                global.upgrade_points -= _row.cost;
                global.mode_mg = true;
            }
        break;

        case "buy_special":

            if (global.mode_special == "none" && global.upgrade_points >= _row.cost)
            {
                global.upgrade_points -= _row.cost;
                global.mode_special = _row.key;
            }
        break;
    }
}

function zs_pick_zombie_type(_wave)
{
    var _r = random(1);
    if (_wave >= 7)
    {
        if (_r < 0.50) return "small";
        if (_r < 0.80) return "medium";
        return "large";
    }
    if (_wave >= 4)
    {
        if (_r < 0.65) return "small";
        return "medium";
    }
    return "small";
}

function zs_spawn_zombie(_type)
{
    var _xx, _yy;
    switch (irandom(3))
    {
        case 0:  _xx = random(room_width);  _yy = -20;                break;
        case 1:  _xx = random(room_width);  _yy = room_height + 20;   break;
        case 2:  _xx = -20;                 _yy = random(room_height); break;
        default: _xx = room_width + 20;     _yy = random(room_height); break;
    }

    var _z = instance_create_layer(_xx, _yy, "Instances", obj_zombie);
    _z.ztype = _type;

    var _base_hp  = 3 + wave;
    var _base_spd = 1 + wave * 0.12;

    switch (_type)
    {
        case "medium":
            _z.sprite_index = spr_zombie_medium;
            _z.hp = _base_hp * 3;  _z.move_speed = _base_spd * 0.85; _z.dmg = 2; _z.score_value = 25;
        break;
        case "large":
            _z.sprite_index = spr_zombie_large;
            _z.hp = _base_hp * 6;  _z.move_speed = _base_spd * 0.6;  _z.dmg = 3; _z.score_value = 50;
        break;
        case "boss":
            _z.sprite_index = spr_boss;
            _z.hp = 120 + wave * 25; _z.move_speed = max(0.6, _base_spd * 0.5); _z.dmg = 6; _z.score_value = 400;
        break;
        default:
            _z.sprite_index = spr_zombie;
            _z.hp = _base_hp; _z.move_speed = _base_spd; _z.dmg = 1; _z.score_value = 10;
        break;
    }

    _z.hp_max = _z.hp;
    return _z;
}

function zs_make_bullet(_x, _y, _dir, _spd, _dmg, _kind, _radius, _fuse)
{
    var _b = instance_create_layer(_x, _y, "Instances", obj_bullet);
    _b.damage = _dmg; _b.direction = _dir; _b.speed = _spd;
    _b.kind = _kind; _b.explode_radius = _radius; _b.fuse = _fuse;

    if (_kind == "rocket")       { _b.sprite_index = spr_rocket;  _b.image_angle = _dir; }
    else if (_kind == "grenade") { _b.sprite_index = spr_grenade; _b.image_angle = _dir; }
    return _b;
}

function zs_player_fire(_dir)
{
    var _spd  = 9;
    var _dirs = global.lvl_dir;
    var _per  = global.lvl_shot;

    for (var _d = 0; _d < _dirs; _d++)
    {
        var _base_dir = _dir + _d * (360 / _dirs);
        if (_per <= 1)
        {
            zs_make_bullet(x, y, _base_dir, _spd, damage, "normal", 0, 0);
        }
        else
        {
            var _spread = 18;
            var _start  = _base_dir - _spread * 0.5;
            var _step   = _spread / (_per - 1);
            for (var _s = 0; _s < _per; _s++)
                zs_make_bullet(x, y, _start + _s * _step, _spd, damage, "normal", 0, 0);
        }
    }

    var _cd = fire_cd_max;
    if (global.mode_mg) _cd = max(3, round(_cd * 0.5));
    return _cd;
}

function zs_kill_zombie(_inst)
{
    var _val = _inst.score_value;
    with (obj_game) game_score += _val;
    global.upgrade_points += _val;
    audio_play_sound(snd_zs_zombie_death, 1, false, global.sfx_volume);
    instance_destroy(_inst);
}

function zs_explode(_x, _y, _radius, _dmg)
{
    var _e = instance_create_layer(_x, _y, "Instances", obj_explosion);
    _e.radius = _radius;

    with (obj_zombie)
    {
        if (point_distance(x, y, _x, _y) <= _radius)
        {
            hp -= _dmg;
            if (hp <= 0) zs_kill_zombie(id);
        }
    }
}

function zs_shop_layout()
{
    var _cx = display_get_gui_width() * 0.5;
    return { cx: _cx, lx: _cx - 220, y0: 168, dy: 26 };
}

function zs_shop_hover(_mx, _my, _count, _has_continue)
{
    var _L  = zs_shop_layout();
    var _x1 = _L.lx - 12;
    var _x2 = _L.lx + 430;

    for (var _i = 0; _i < _count; _i++)
    {
        var _ry = _L.y0 + _i * _L.dy;
        if (_mx >= _x1 && _mx <= _x2 && _my >= _ry - 3 && _my <= _ry + _L.dy - 5) return _i;
    }
    if (_has_continue)
    {
        var _cry = _L.y0 + _count * _L.dy + 8;
        if (_mx >= _x1 && _mx <= _x2 && _my >= _cry - 3 && _my <= _cry + _L.dy - 5) return _count;
    }
    return -1;
}

function zs_gameover_btn_rects()
{
    var _cx = display_get_gui_width()  * 0.5;
    var _by = display_get_gui_height() * 0.5 + 60;
    return {
        restart: { x1: _cx - 180, y1: _by, x2: _cx - 20,  y2: _by + 28 },
        menu:    { x1: _cx + 20,  y1: _by, x2: _cx + 180, y2: _by + 28 },
    };
}

function zs_ability_btn_rects()
{
    return {
        bomb: { x1: 18, y1: 140, x2: 250, y2: 160 },
        heal: { x1: 18, y1: 162, x2: 250, y2: 182 },
    };
}
