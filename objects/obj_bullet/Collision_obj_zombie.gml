if (kind == "normal")
{

    other.hp -= damage;
    if (other.hp <= 0) zs_kill_zombie(other);
    instance_destroy();
}
else
{

    zs_explode(x, y, explode_radius, damage);
    instance_destroy();
}
