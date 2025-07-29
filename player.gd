extends CharacterBody2D

const SPEED = 70

var input_direction: get = _get_input_direction 
var sprite_direction = "S": get = _get_sprite_direction

@onready var sprite = $AnimatedSprite2D

@onready var all_interactions = []
@onready var interactLabel = $"InteractionComponents/Label"
@onready var interactArea = $"InteractionComponents/InteractionArea"
@onready var fishAlert = $"FishingComponents/Alert"
@onready var fishTimer = $"FishingComponents/FishTimer"

@onready var textBox = get_tree().get_nodes_in_group("TextBox")[0]

var rng = RandomNumberGenerator.new()

var fishing = false
var fish_hooked = false

func _ready():
	if Global.player_spawn_position != Vector2.ZERO:
		self.global_position = Global.player_spawn_position
		Global.player_spawn_position = Vector2.ZERO  # Clear it afterward


func _physics_process(_delta):
	if !Global.interact:
		velocity = input_direction * SPEED
		move_and_slide()
		
		set_animation("Walk")
		if velocity == Vector2.ZERO:
			set_animation("Idle")
	if fishing:
		if !fish_hooked:
			if rng.randi_range(0,120) == 0:
				fish_hooked = true
				fishAlert.visible = true
				fishTimer.start()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()


func fish_missed():
	fish_hooked = false
	Global.interact = false
	fishAlert.visible = false
	fishing = false

func set_animation(animation):
	var direction = sprite_direction
	sprite.play(animation + direction)


func _get_input_direction():
	var x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	var y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
	input_direction = Vector2(x,y).normalized()
	return input_direction


func _get_sprite_direction():
	match input_direction:
		Vector2.LEFT:
			sprite_direction = "A"
			interactArea.rotation_degrees = 90
		Vector2.RIGHT:
			sprite_direction = "D"
			interactArea.rotation_degrees = 270
		Vector2.UP:
			sprite_direction = "W"
			interactArea.rotation_degrees = 180
		Vector2.DOWN:
			sprite_direction = "S"
			interactArea.rotation_degrees = 0
	return sprite_direction


func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	var current_interaction = all_interactions[0]
	if current_interaction.interact_type == "scene_change":
		scene_change(current_interaction)

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	#update_interactions()
	
#func update_interactions():
	#if all_interactions:
		#interactLabel.text = all_interactions[0].interact_label
	#else:
		#interactLabel.text = ""
		
func scene_change(area):
	match area.direction:
		"North":
			Global.player_spawn_position = Vector2(self.global_position.x, 115)
		"East":
			Global.player_spawn_position = Vector2(8, self.global_position.y)
		"South":
			Global.player_spawn_position = Vector2(self.global_position.x, 8)
		"West":
			Global.player_spawn_position = Vector2(152, self.global_position.y)

	get_tree().change_scene_to_file(area.map)

func execute_interaction():
	print(self.global_position[0])
	if all_interactions:
		var current_interaction = all_interactions[0]
		match current_interaction.interact_type:
			"print_text": print(current_interaction.interact_value)

			"text_box":
				if Global.interact:
					Global.interact = false
					textBox.visible = false
				else:
					textBox.visible = true
					Global.interact = true

			"fish_area":
				if Global.interact:
					if fish_hooked:
						print("You caught fish")
						Global.interact = false
						fish_hooked = false
						fishAlert.visible = false
						fishing = false
						fishTimer.stop()
					else:
						Global.interact = false
						fishing = false
				else:
					Global.interact = true
					fishing = true
