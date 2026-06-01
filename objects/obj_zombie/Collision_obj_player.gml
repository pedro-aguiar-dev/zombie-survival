/// obj_zombie - Collision com obj_player
// Causa dano por contato, respeitando o intervalo entre golpes.
if (atk_cd <= 0)
{
    other.hp -= dmg;
    atk_cd = atk_cd_max;
}
