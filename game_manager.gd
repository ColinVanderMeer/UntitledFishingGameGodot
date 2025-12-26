extends Node

@onready var current_level_node: Node = get_node("../MainMenu")

func _ready():
	pass

func load_level(scene_path: String):
	call_deferred("_deferred_scene_change", scene_path)

func _deferred_scene_change(scene_path: String):
	if current_level_node != null:
		current_level_node.queue_free()
		current_level_node = null
	
	var new_scene_resource = load(scene_path)
	var new_level = new_scene_resource.instantiate()
	get_parent().add_child(new_level)
	current_level_node = new_level
