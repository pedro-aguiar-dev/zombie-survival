
// When we click the hero, and the recruit panel isn't already open,
// Then open the recruit panel.
if (!instance_exists(obj_recruit_panel)) {
	var _panel = instance_create_layer(146, 3, "Effects", obj_recruit_panel);
	_panel.target = object_index;
}
