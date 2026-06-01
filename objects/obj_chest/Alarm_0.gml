
// Destroy the chest.
// Give the reward.
// Trigger alarm[1] of the monster spawner, this is the alarm that changes the scene.
instance_destroy();
global.gold += reward;
obj_monster_spawn.alarm[1] = 20;
