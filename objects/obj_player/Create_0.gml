var _fps = game_get_speed(gamespeed_fps);

damage      = 1 + global.up_damage;
move_speed  = 3 + global.up_speed * 0.4;
fire_cd_max = max(6, 25 - global.up_firerate * 2);
hp_max      = 5 + global.up_maxhp;
hp          = hp_max;

fire_cd = 0;
last_aim_dir = 0;

bazooka_cd = 0;
grenade_cd = 0;

prev_hp    = hp;
hurt_timer = 0;

bomb_cd     = 0;
bomb_cd_max = 5 * _fps;
bomb_radius = 160;

heal_cd     = 0;
heal_cd_max = 8 * _fps;
heal_amount = 3;

arena_margin = 20;
