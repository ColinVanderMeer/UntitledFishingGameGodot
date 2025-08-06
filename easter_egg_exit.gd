extends Area3D

@export_file("*.tscn") var map



func _on_area_entered(area: Area3D) -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.player_spawn_position = Vector2(61, 47)
	call_deferred("_deferred_scene_change", self.map)

func _deferred_scene_change(map_path):
	get_tree().change_scene_to_file(map_path)
