extends Node

# Use this to keep track of the current level node
@onready var current_level_node: Node = get_node("../MainMenu")

func _ready():
	pass

func load_level(scene_path: String):
	# We call deferred here to ensure safe execution
	call_deferred("_deferred_scene_change", scene_path)

func _deferred_scene_change(scene_path: String):
	# 1. Remove the old level
	if current_level_node != null:
		current_level_node.queue_free()
		current_level_node = null # Safety reset
	
	# 2. Load the new resource
	var new_scene_resource = load(scene_path)
	
	# 3. Instantiate the new level
	var new_level = new_scene_resource.instantiate()
	
	# 4. Add it as a child of the VIEWPORT (the parent of this manager)
	get_parent().add_child(new_level)
	
	# 5. Update our reference
	current_level_node = new_level
