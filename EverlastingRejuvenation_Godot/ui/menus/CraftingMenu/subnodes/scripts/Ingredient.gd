class_name Ingredient extends CharacterBody2D

@export var ingredient_id : int;

# Default Movement
@onready var default_position : Vector2 = position;
@onready var desired_position : Vector2 = default_position;

# Mouse Following Variables
var new_position : Vector2;
var dragging_distance : float;
var direction : Vector2;
var dragging : bool;
var mouse_in = false;

func _ready() -> void:
	get_node("IngredientSprite").frame = ingredient_id-1;

func _input(event):
	# If Event is a Mouse Click
	if event is InputEventMouseButton:
		# Continues Dragging until Release
		if event.is_pressed() && mouse_in:
			dragging = true;
			dragging_distance = position.distance_to(get_global_mouse_position());
			direction = (get_global_mouse_position() - position).normalized();
			new_position = get_global_mouse_position() - dragging_distance * direction
		else:
			dragging = false;
	# Follows on Mouse Movement
	elif event is InputEventMouseMotion:
		if dragging:
			new_position = get_global_mouse_position()

func _physics_process(_delta: float) -> void:
	if dragging:
		velocity = (new_position - position) * Vector2(30, 30);
	else:
		if (desired_position == default_position):
			velocity = (desired_position - position) * Vector2(2.5, 2.5);
		else:
			velocity = (desired_position - position) * Vector2(10, 10);
	move_and_slide();

func reset_desired_position():
	desired_position = default_position;

func handle_close():
	position = default_position;
	desired_position = default_position;

func _mouse_entered() -> void:
	mouse_in = true;

func _mouse_exited() -> void:
	mouse_in = false;
