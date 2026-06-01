/// obj_menu - Create
zs_init_globals();
audio_master_gain(global.master_volume);

sel       = 0;            // linha selecionada
menu_count = 4;           // [0]Jogar [1]Volume Geral [2]Volume SFX [3]Sair
prev_mx   = 0;            // posição anterior do mouse (GUI) p/ hover vs teclado
prev_my   = 0;
