class_name State extends Node

signal transitioned(new_state_name : StringName)

@export var animation_name : String;
@export var parent : Node2D;

# When Entering this State
func Enter() -> void:
	parent.get_node("Visuals/Animations").play(animation_name);

# When Exiting this State
func Exit() -> void:
	pass;

# Handle User Inputs
func Process_Input(_input : InputEvent) -> void:
	pass;

# Perform at Process Calls
func Update(_delta: float) -> void:
	# Handle Sprite Direction Based on Movement
	if (parent.velocity.x != 0):
		if (parent.velocity.x < 0): parent.get_node("Visuals/Sprite").flip_h = true;
		else: parent.get_node("Visuals/Sprite").flip_h = false;

# Perform at Physics Process Calls
func Physics_Update(_delta: float) -> void:
	pass;
