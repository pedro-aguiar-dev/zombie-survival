
// Destroy the tutorial arrow if it exists.
// We do this in the step as if you already have the panel open, the Create event won't catch it.
with (obj_tutorial_arrow) {
	if (visible)
		instance_destroy();
}
