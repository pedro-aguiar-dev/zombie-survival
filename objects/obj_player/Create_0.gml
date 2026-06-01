/// obj_player - Create
var _fps = game_get_speed(gamespeed_fps);

// Stats derivados dos upgrades persistentes
damage      = 1 + global.up_damage;
move_speed  = 3 + global.up_speed * 0.4;
fire_cd_max = max(6, 25 - global.up_firerate * 2);
hp_max      = 5 + global.up_maxhp;
hp          = hp_max;

// Cooldown do tiro automático
fire_cd = 0;
last_aim_dir = 0;

// Cooldowns das armas automáticas extras
bazooka_cd = 0;
grenade_cd = 0;

// Animação de dano (pisca vermelho ao levar dano)
prev_hp    = hp;
hurt_timer = 0;

// Habilidade BOMBA (tecla E)
bomb_cd     = 0;
bomb_cd_max = 5 * _fps;
bomb_radius = 160;

// Habilidade CURA (tecla Q)
heal_cd     = 0;
heal_cd_max = 8 * _fps;
heal_amount = 3;

// Margem de clamp dentro da arena
arena_margin = 20;
