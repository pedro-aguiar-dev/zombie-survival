/// obj_zombie - Create
var _fps = game_get_speed(gamespeed_fps);

ztype       = "small";  // small | medium | large | boss (definido pelo spawner)
hp          = 3;        // sobrescrito por zs_spawn_zombie conforme tipo/onda
hp_max      = 3;
move_speed  = 1;
dmg         = 1;
score_value = 10;       // pontos ao morrer (varia por tipo)

// Intervalo entre golpes por contato
atk_cd     = 0;
atk_cd_max = 0.5 * _fps;
