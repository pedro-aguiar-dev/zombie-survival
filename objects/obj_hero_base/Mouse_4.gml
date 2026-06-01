if (!instance_exists(obj_recruit_panel)) {
	var _panel = instance_create_layer(146, 3, "Effects", obj_recruit_panel);
	_panel.target = object_index;
}
