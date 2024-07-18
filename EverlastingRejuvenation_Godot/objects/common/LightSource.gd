extends PointLight2D

@export var noise : NoiseTexture2D;
var time : float = 0;

func _process(delta: float) -> void:
	time += delta;
	var sampled_noise = abs(noise.noise.get_noise_1d(time));
	energy = 1 + sampled_noise;
