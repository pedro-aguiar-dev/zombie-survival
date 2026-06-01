/// obj_explosion - Create
// O dano em área é aplicado por zs_explode() ao criar; aqui só o visual temporário.
radius = 60;                                       // sobrescrito por quem cria
life_max = max(1, round(0.25 * game_get_speed(gamespeed_fps)));
life     = life_max;
alarm[0] = life_max;
