extends Node2D

@export_file("*.tscn") var map

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		Global.load_data()
		call_deferred("_deferred_scene_change", map)

func _deferred_scene_change(map_path):
	get_tree().change_scene_to_file(map_path)
