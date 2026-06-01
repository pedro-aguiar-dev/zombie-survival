function hit_monster(_damage)
{

	if (!instance_exists(obj_monster_base))
		return;

	audio_play_sound(snd_enemy_hit, 0, false, 0.1, 0, random_range(0.6, 1.4));

	var _total_damage = min(obj_monster_base.hitpoints, _damage);
	obj_monster_base.hitpoints -= _total_damage;
	global.gold += _total_damage;

	var _x = obj_monster_base.x;
	var _y = obj_monster_base.y;
	repeat (_total_damage)
		instance_create_layer(_x, _y - 50, "Effects", obj_hit_effect);

	if (obj_monster_base.hitpoints <= 0) {
		audio_play_sound(snd_enemy_death, 0, false);
		instance_destroy(obj_monster_base);
	}
}

function select_next_hero_slot(_direction)
{

	var _ordered = [
		obj_prince,
		obj_princess,
		obj_sir_prancelot,
		obj_spellmage,
		obj_fluffy,
		obj_thokk_steelpecs,
		obj_glitter_lizard
	];

	var _current = 0;
	for (var _i = 0; _i < 7; _i++) {
		if (obj_recruit_panel.target == _ordered[_i])
			_current = _i;
	}

	var _next = (_current + _direction + 7) % 7;
	obj_recruit_panel.target = _ordered[_next];
}
