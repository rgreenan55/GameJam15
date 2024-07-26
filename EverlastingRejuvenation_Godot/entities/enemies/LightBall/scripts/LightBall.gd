extends CharacterBody2D

@onready var state_machine : StateMachine = $LightBallStateMachine;
@onready var patience_timer : Timer = get_node("LineOfSight/PatienceTimer");

func _on_line_of_sight_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		state_machine.on_child_transitioned("LightBallAlert");
		patience_timer.stop();

func _on_line_of_sight_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		patience_timer.start();

func _on_patience_timer_timeout() -> void:
		state_machine.on_child_transitioned("LightBallIdle");

func explode():
	state_machine.on_child_transitioned("LightBallAlert");
	patience_timer.start();
