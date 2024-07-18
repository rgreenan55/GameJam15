extends State

var progress : float = 0;

# Perform at Process Calls
func Update(delta: float) -> void:
	super(delta);

	# Code to Move Along the Bezier
	var lerp0 = parent.start_position.lerp(parent.mid_position, progress);
	var lerp1 = parent.mid_position.lerp(parent.end_position, progress);
	var move_vector = lerp0.lerp(lerp1, progress);
	parent.position = move_vector;
	progress += 0.75 * delta;

	if (progress >= 1.0):
		transitioned.emit(&"PotionLandedState")
