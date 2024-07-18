class_name StateMachine extends Node

@export var current_state : State;
var states : Dictionary = {};

func _ready() -> void:
	for state in get_children():
		if (state is State):
			states[state.name] = state;
			state.parent = get_parent();
			state.transitioned.connect(on_child_transitioned);
		else:
			push_warning("State Machine (", self.name, ") contains child which is not a 'State': ", state.name);
	current_state.Enter()

func _process(delta: float) -> void:
	current_state.Update(delta);

func _physics_process(delta: float) -> void:
	current_state.Physics_Update(delta);

func _unhandled_input(event : InputEvent) -> void:
	current_state.Process_Input(event);

func on_child_transitioned(new_state_name : StringName) -> void:
	var new_state = states.get(new_state_name);
	if (new_state != null):
		if (new_state != current_state):
			current_state.Exit();
			new_state.Enter();
			current_state = new_state;
	else:
		push_warning("Called transition on state that does not exist");

