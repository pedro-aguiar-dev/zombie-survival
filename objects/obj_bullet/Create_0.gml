/// obj_bullet - Create
// direction e speed são definidos por quem cria a bala (obj_player / zs_make_bullet).
damage         = 1;
speed          = 8;
kind           = "normal";   // "normal" | "rocket" | "grenade"
explode_radius = 0;          // usado por rocket/grenade
fuse           = 0;          // passos até explodir (grenade); 0 = sem pavio
