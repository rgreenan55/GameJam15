extends State

var progress : float = 0;

func Enter() -> void:
	parent.position = parent.start_position;

# Perform at Process Calls
func Update(delta: float) -> void:
	super(delta);

	# Code to Move Along the Bezier
	var lerp0 = parent.start_position.lerp(parent.middle_position, progress);
	var lerp1 = parent.middle_position.lerp(parent.end_position, progress);
	var move_vector = lerp0.lerp(lerp1, progress);
	parent.position = move_vector;
	progress += 0.75 * delta;

	if (progress >= 1.0):
		transitioned.emit(&"PotionLandedState")
