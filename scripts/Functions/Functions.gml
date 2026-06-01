
/**
 * Function to hit the monster. Called by both clicking and my heros.
 */
function hit_monster(_damage)
{
	// If a monster doesn't exist, just exit from this function.
	if (!instance_exists(obj_monster_base))
		return;
	
	// Play sound effect.
	audio_play_sound(snd_enemy_hit, 0, false, 0.1, 0, random_range(0.6, 1.4));
	
	// Get the total damage to deal, based on what health is left on the monster.
	// Deal this in hitpoints and gold reward.
	var _total_damage = min(obj_monster_base.hitpoints, _damage);
	obj_monster_base.hitpoints -= _total_damage;
	global.gold += _total_damage;
	
	// Create coin effects.
	var _x = obj_monster_base.x;
	var _y = obj_monster_base.y;
	repeat (_total_damage)
		instance_create_layer(_x, _y - 50, "Effects", obj_hit_effect);

	// If the monster has no hitpoints left, destroy it.
	if (obj_monster_base.hitpoints <= 0) {
		audio_play_sound(snd_enemy_death, 0, false);
		instance_destroy(obj_monster_base);
	}
}

/**
 * Function to select the next hero from the recruit panel.
 */
function select_next_hero_slot(_direction)
{
	// The correct order of the heros.
	var _ordered = [
		obj_prince,
		obj_princess,
		obj_sir_prancelot,
		obj_spellmage,
		obj_fluffy,
		obj_thokk_steelpecs,
		obj_glitter_lizard
	];
	
	// Index of the currently selected hero in that from.
	var _current = 0;
	for (var _i = 0; _i < 7; _i++) {
		if (obj_recruit_panel.target == _ordered[_i])
			_current = _i;
	}
	
	// Select the next/previous one.
	var _next = (_current + _direction + 7) % 7;
	obj_recruit_panel.target = _ordered[_next];
}
