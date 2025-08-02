extends CharacterBody2D

const SPEED = 70

var input_direction: get = _get_input_direction 
var sprite_direction = "S": get = _get_sprite_direction

@onready var sprite = $AnimatedSprite2D

@onready var all_interactions = []
@onready var interactArea = $"InteractionComponents/InteractionArea"
@onready var fishAlert = $"FishingComponents/Alert"
@onready var fishTimer = $"FishingComponents/FishTimer"

@onready var userInterface = get_tree().get_nodes_in_group("UserInterface")[0]
@onready var textBox = userInterface.get_node("TextBox")
@onready var textBoxLabel = userInterface.get_node("TextBox/TextBoxLabel")
@onready var textBoxFishSprite = userInterface.get_node("TextBox/FishSprite")

var rng = RandomNumberGenerator.new()

var fishing = false
var fish_hooked = false
var fish_box_up = false

func _ready():
	if Global.player_spawn_position != Vector2.ZERO:
		self.global_position = Global.player_spawn_position
		Global.player_spawn_position = Vector2.ZERO  # Clear it afterward


func _physics_process(_delta):
	if !Global.interact:
		velocity = input_direction * SPEED
		move_and_slide()
		
		if velocity == Vector2.ZERO:
			set_animation("Idle")
		else: 
			set_animation("Walk")
			
	if fishing:
		if !fish_hooked:
			fishing_process()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
		
	# For some reason if the character is ever on .0 it messes up the rendering?
	# This is a hack fix cuz I can't figure out why it does that
	if abs(self.global_position.x - int(self.global_position.x)) < 0.1:
		self.global_position.x += 0.1
	if abs(self.global_position.y - int(self.global_position.y)) < 0.1:
		self.global_position.y += 0.1
	if abs(self.global_position.x - int(self.global_position.x)) > 0.9:
		self.global_position.x -= 0.1
	if abs(self.global_position.y - int(self.global_position.y)) < 0.9:
		self.global_position.y -= 0.1

func fishing_process():
	if rng.randi_range(0,120) == 0:
		fish_hooked = true
		fishAlert.visible = true
		fishTimer.start()

func fish_missed():
	fish_hooked = false
	Global.interact = false
	fishAlert.visible = false
	fishing = false
	
func catch_fish():
	var fish_caught = select_fish()
	var fish_info = Global.fish_data[fish_caught]
	var fish_weight = generate_fish_weight(fish_caught)
	
	if Global.fish_max_weight[fish_caught] < fish_weight:
		Global.fish_max_weight[fish_caught] = fish_weight
	
	textBoxLabel.text = "You caught a %s weighing %.2f kg!" % [fish_info.name, fish_weight]
	textBox.visible = true
	
	textBoxFishSprite.texture = load(fish_info.texture)
	textBoxFishSprite.visible = true
	

	fishing = false
	fish_hooked = false
	fishAlert.visible = false
	fishTimer.stop()
	
	fish_box_up = true
	

	
func select_fish():
	var common_fish = [
		Global.fish_list.clown,
		Global.fish_list.cod,
		Global.fish_list.salmon,
		Global.fish_list.pufferfish,
		Global.fish_list.tuna,
		Global.fish_list.sea_bass,
		Global.fish_list.catfish
	]
	
	var rare_fish = [
		Global.fish_list.pig_fish,
		Global.fish_list.singing_fish,
		Global.fish_list.machine_fish,
		Global.fish_list.drimp,
		Global.fish_list.shark
	]
	
	var hack_rare_fish = [
		Global.fish_list.at_fish,
		Global.fish_list.magical_frog,
		Global.fish_list.orpheus
	]

	var roll = rng.randf()

	if roll >= 0.95: # 5% chance hack rare
		return hack_rare_fish[rng.randi_range(0, hack_rare_fish.size() - 1)]
	elif roll >= 0.75: # 20% chance rare
		return rare_fish[rng.randi_range(0, rare_fish.size() - 1)]
	else: # 75% chance common
		return common_fish[rng.randi_range(0, common_fish.size() - 1)]
		
func generate_fish_weight(fish_type):
	var range = Global.fish_data[fish_type].weight
	var min_w = range.x
	var max_w = range.y

	var roll = rng.randf()
	var weight = min_w + pow(roll, 2.5) * (max_w - min_w)

	return weight

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
		
func scene_change(area):
	match area.direction:
		0: # North
			Global.player_spawn_position = Vector2(self.global_position.x, 115)
		1: # East
			Global.player_spawn_position = Vector2(8, self.global_position.y)
		2: # South
			Global.player_spawn_position = Vector2(self.global_position.x, 8)
		3: # West
			Global.player_spawn_position = Vector2(152, self.global_position.y)
		4:
			Global.player_spawn_position = area.custom_coordinates

	call_deferred("_deferred_scene_change", area.map)

func _deferred_scene_change(map_path):
	get_tree().change_scene_to_file(map_path)

func execute_interaction():
	if all_interactions:
		var current_interaction = all_interactions[0]
		print(Global.fish_max_weight)
		match current_interaction.interact_type:
			"print_text": print(current_interaction.interact_value)

			"text_box":
				if Global.interact:
					Global.interact = false
					textBox.visible = false
				else:
					textBoxLabel.text = current_interaction.interact_value
					textBox.visible = true
					Global.interact = true

			"fish_area":
				if Global.interact: # If fishing
					if fish_hooked && !fish_box_up: 
						catch_fish()
					else: # Stop fishing
						Global.interact = false
						fishing = false
						
						textBoxFishSprite.visible = false
						textBox.visible = false
						fish_box_up = false
				else: # Start fishing
					Global.interact = true
					fishing = true
