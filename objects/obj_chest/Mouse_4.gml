if (!opened) {
	opened = true;
	image_index = 1;
	audio_play_sound(snd_open_chest, 0, false);

	if (obj_monster_spawn.stage % 2 == 0) {
		var _key = instance_create_layer(random_range(x-10, x + 10), y - 20, "Effects", obj_hit_effect);
		_key.direction = random_range(100, 80);
		_key.sprite_index = spr_key;
		_key.alarm[0] = 240;
	}
}
