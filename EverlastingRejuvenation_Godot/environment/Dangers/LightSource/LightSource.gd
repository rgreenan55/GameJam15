extends PointLight2D

@export var default_state : bool = true;
@export var noise : NoiseTexture2D;
@export var is_extinguishable : bool = true;

var player_light_detector : CollisionShape2D;
var time : float = 0;

func _ready() -> void:
	if (!default_state): extinguish();

func _process(delta: float) -> void:
	randomize_light(delta);
	process_raycast();

func process_raycast() -> void:
	if (!player_light_detector): return;
	# Look At Player
	var raycast1 : RayCast2D = get_node("Raycast");
	raycast1.look_at(player_light_detector.global_position);
	# Check if Colliding with Player - Need to Improve this
	if (raycast1.is_colliding()):
		var collider = raycast1.get_collider();
		if (collider.is_in_group("Player")):
			collider.hit_by_light();

func randomize_light(delta: float) -> void:
	time += delta;
	var sampled_noise = abs(noise.noise.get_noise_1d(time));
	self.energy = 1 + sampled_noise;

# Extinguish Due to Player
func extinguish() -> void:
	# Light Source Extinguish Effect
	if (is_extinguishable):
		get_node("AreaOfEffect").set_deferred("monitorable", false);
		get_node("AreaOfEffect/AreaOfCollision").set_deferred("disabled", true);
		get_node("Raycast").set_deferred("enabled", false);
		get_node("ExtinguishSound").playing = true;
		self.enabled = false;
	# Call Parent Specific Extinguish - For Sprite Changes etc.
	if (get_parent().has_method("extinguish")):
		get_parent().extinguish();

# Extinguish Not Due to Player
func force_extinguish() -> void:
	get_node("AreaOfEffect").set_deferred("monitorable", false);
	get_node("AreaOfEffect/AreaOfCollision").set_deferred("disabled", true);
	get_node("Raycast").set_deferred("enabled", false);
	self.enabled = false;

func relight() -> void:
	get_node("AreaOfEffect").set_deferred("monitorable", true);
	get_node("AreaOfEffect/AreaOfCollision").set_deferred("disabled", false);
	get_node("Raycast").set_deferred("enabled", true);
	self.enabled = true;

func _on_area_of_effect_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")):
		player_light_detector = body.get_node("CollisionShape");
