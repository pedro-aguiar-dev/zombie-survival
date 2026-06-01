var _damage = 1;

with (obj_hero_base)
	_damage += (unlocked ? click_bonus : 0);

hit_monster(_damage);
