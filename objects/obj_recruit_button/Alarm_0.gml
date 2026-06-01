if (global.gold >= obj_recruit_panel.target.cost && !obj_recruit_panel.target.unlocked) {
	global.gold -= obj_recruit_panel.target.cost;
	obj_recruit_panel.target.unlocked = true;
	instance_destroy(obj_recruit_panel);
}
