class_name Wizard extends CharacterBody2D

# Signals
signal player_death();
signal throw_potion(start : Vector2, end : Vector2);

# State Machine
@onready var state_machine : StateMachine = $WizardStateMachine;

# Shadow Timer Variables
@export var out_of_shadow : bool = true;
var number_of_shadows : int = 0;
@onready var life_bar : ProgressBar = get_node("ShadowHandler/ShadowLifeBar");
var life_bar_shown : bool = true;
var max_time : float = 10;
var time : float = 10;

func _process(delta: float) -> void:
	if (out_of_shadow): time -= delta;
	else: time += delta * 2;
	life_bar.value = time / max_time * 100;
	time = clampf(time, 0, max_time);

	if (time == 0): hit_by_light();
	elif (time == 10 && life_bar_shown): fade_out_life_bar();

func hit_by_light() -> void:
	life_bar.visible = false;
	state_machine.on_child_transitioned("WizardDyingState");

func exited_shadow() -> void:
	number_of_shadows -= 1;
	if (number_of_shadows == 0):
		if (!life_bar_shown):
			fade_in_life_bar();
		out_of_shadow = true;

func entered_shadow() -> void:
	number_of_shadows += 1;
	out_of_shadow = false;

func fade_out_life_bar() -> void:
	life_bar_shown = false;
	var tween = create_tween();
	tween.tween_property(life_bar, "modulate", Color(1,1,1,0), 1.0);

func fade_in_life_bar() -> void:
	life_bar_shown = true;
	var tween = create_tween();
	tween.tween_property(life_bar, "modulate", Color(1,1,1,1), 1.0);
