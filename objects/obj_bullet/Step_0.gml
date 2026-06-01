if (fuse > 0)
{
    fuse -= 1;
    if (fuse <= 0)
    {
        zs_explode(x, y, explode_radius, damage);
        instance_destroy();
    }
}
