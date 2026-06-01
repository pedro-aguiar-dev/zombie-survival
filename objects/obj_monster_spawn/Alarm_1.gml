
// Set the scene based on the stage.
switch (stage) {
case 0:
	sprite_index = spr_castle;
	break;
case 1:
	sprite_index = spr_castle;
	break;
case 2:
	sprite_index = spr_fireplace;
	break;
case 3:
	sprite_index = spr_fireplace;
	break;
case 4:
	sprite_index = spr_throne;
	break;
case 5:
	sprite_index = spr_throne;
	break;
}

// Set alarm 0 the 1.5 seconds, this gives the user enough time
// to see that the scene has changed before spawning a monster.
alarm[0] = 90;
