var _fps = game_get_speed(gamespeed_fps);

zs_init_globals();
global.games_played += 1;
audio_master_gain(global.master_volume);

shop_sel = 0;
prev_mx  = 0;
prev_my  = 0;

state           = "wave_break";
wave            = 0;
game_score      = 0;
survival_frames = 0;

to_spawn     = 0;
spawn_cd     = 0;
spawn_cd_max = max(1, floor(0.35 * _fps));

break_timer = 2 * _fps;

player_hp     = 1;
player_hp_max = 1;
