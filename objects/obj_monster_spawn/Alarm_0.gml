var _monster = obj_dracula;
switch (stage) {
case 0:
	_monster = obj_gargoyle;
	break;
case 1:
	_monster = obj_skeleton;
	break;
case 2:
	_monster = obj_mudslime;
	break;
case 3:
	_monster = obj_pumpkin;
	break;
case 4:
	_monster = obj_doom_hand;
	break;
case 5:
	_monster = obj_dracula;
	break;
case 6:
	room_goto(rm_victory);
	exit;
}

instance_create_layer(x, y, "Units", _monster);

stage += 1;
