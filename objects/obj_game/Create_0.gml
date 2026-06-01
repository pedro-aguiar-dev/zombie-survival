/// obj_game - Create (controlador de ondas, pontuação e estado)
var _fps = game_get_speed(gamespeed_fps);

zs_init_globals();
global.games_played += 1;          // conta esta partida (inclui room_restart)
audio_master_gain(global.master_volume);

shop_sel = 0;                      // linha selecionada na loja
prev_mx  = 0;                      // posição anterior do mouse (GUI) p/ hover vs teclado
prev_my  = 0;

state           = "wave_break";  // "wave_break" | "playing" | "gameover"
wave            = 0;
game_score      = 0;
survival_frames = 0;             // tempo de sobrevivência (em passos)

// Controle de spawn gradual
to_spawn     = 0;
spawn_cd     = 0;
spawn_cd_max = max(1, floor(0.35 * _fps));

// Pausa entre ondas (segundos -> passos)
break_timer = 2 * _fps;

// Cache da vida do player para o HUD (continua válido após a morte)
player_hp     = 1;
player_hp_max = 1;
