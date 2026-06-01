
// Bob the sprite up and down.
y = ystart + sin(current_time / 100) * 2;

// On show the sprite if we can afford the first hero.
visible = global.gold >= 40;
