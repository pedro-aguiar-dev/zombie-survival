
// Trigger this event again shortly.
alarm[0] = cooldown;

// If unlocked, we can hit the monster.
if (unlocked) {
	hit_monster(damage);
}
