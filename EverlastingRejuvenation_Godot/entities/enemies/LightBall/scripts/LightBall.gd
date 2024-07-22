extends CharacterBody2D

@onready var state_machine : StateMachine = $LightBallStateMachine;

func _on_line_of_sight_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		state_machine.on_child_transitioned("LightBallAlert");
		get_node("LineOfSight/PatienceTimer").stop();

func _on_line_of_sight_body_exited(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		get_node("LineOfSight/PatienceTimer").start();


func _on_patience_timer_timeout() -> void:
		state_machine.on_child_transitioned("LightBallIdle");
