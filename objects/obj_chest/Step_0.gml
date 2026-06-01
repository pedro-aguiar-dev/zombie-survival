if (opened && alarm[0] == -1) {
	var _coin = instance_create_layer(random_range(x-10, x + 10), y - 20, "Effects", obj_hit_effect);
	_coin.direction = random_range(100, 80);
	if (coin_spawn_counter-- <= 0) {
		if (obj_monster_spawn.stage % 2 == 0)
			alarm[0] = 120;
		else
			alarm[0] = 30;
	}
}
