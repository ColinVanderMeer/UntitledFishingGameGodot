extends Node

@onready var current_level_node: Node = get_node("../MainMenu")

func _ready():
	pass

func load_level(scene_path: String):
	call_deferred("_deferred_scene_change", scene_path)

func _deferred_scene_change(scene_path: String):
	if current_level_node != null:
		if current_level_node.has_node("Player"):
			current_level_node.get_node("Player").set_physics_process(false)
		current_level_node.free()
		current_level_node = null
	
	var new_scene_resource = load(scene_path)
	var new_level = new_scene_resource.instantiate()
	get_parent().add_child(new_level)
	current_level_node = new_level
