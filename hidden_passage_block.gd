extends TileMapLayer

var rng = RandomNumberGenerator.new()

func _ready():
	if rng.randi_range(0,10) == 0 && Global.player_spawn_position != Vector2(61, 47):
		self.queue_free()
