var _unlocked = obj_recruit_panel.target.unlocked;
var _can_afford = global.gold >= obj_recruit_panel.target.cost;
image_index = ((_unlocked || !_can_afford) ? 0 : 1);
