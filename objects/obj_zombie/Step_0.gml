/// obj_zombie - Step

if (atk_cd > 0) atk_cd -= 1;

// Persegue o jogador continuamente
var _p = instance_nearest(x, y, obj_player);
if (instance_exists(_p))
{
    var _dir = point_direction(x, y, _p.x, _p.y);
    x += lengthdir_x(move_speed, _dir);
    y += lengthdir_y(move_speed, _dir);
}
