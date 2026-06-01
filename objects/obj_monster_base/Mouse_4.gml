
// Do damage to the monster when we click it.
// The damage is a base of 1, but every unlocked hero gives us a bonus to click, so we just add up all those bonuses.
var _damage = 1;

with (obj_hero_base)
	_damage += (unlocked ? click_bonus : 0);

hit_monster(_damage);
