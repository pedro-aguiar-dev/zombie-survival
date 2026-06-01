/// obj_bullet - Collision com obj_zombie
if (kind == "normal")
{
    // Dano direto num único zumbi
    other.hp -= damage;
    if (other.hp <= 0) zs_kill_zombie(other);
    instance_destroy();
}
else
{
    // Rocket/granada: explode em área no ponto de impacto
    zs_explode(x, y, explode_radius, damage);
    instance_destroy();
}
