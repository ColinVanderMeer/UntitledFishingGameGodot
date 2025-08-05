extends CharacterBody3D


const SPEED = 5.0

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var raycaster := $Neck/Camera3D/RayCast3D

@onready var fishAlert = get_tree().get_nodes_in_group("fishAlert")[0]
@onready var fishSpin = get_tree().get_nodes_in_group("fishSpin")[0]


var fishing = false
var fish_hooked = false

var rng = RandomNumberGenerator.new()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if raycaster.is_colliding():
		var collider = raycaster.get_collider()
		
		if collider.name == "Water":
			if Input.is_action_just_pressed("interact"):
				if Global.interact: # If fishing
					if fish_hooked: 
						catch_fish()
					else: # Stop fishing
						Global.interact = false
						fishing = false
						$Neck/Camera3D/Rod.visible = false
				else: # Start fishing
					Global.interact = true
					fishing = true
					$Neck/Camera3D/Rod.visible = true
					
					
	if fishing:
		if !fish_hooked:
			fishing_process()

	if !Global.interact:
		move_and_slide()

func fishing_process():
	if rng.randi_range(0,120 - Global.catch_speed_increase * 5) == 0:
		fish_hooked = true
		fishAlert.visible = true

func catch_fish():
	Global.interact = false
	$Neck/Camera3D/Rod.visible = false
	fishAlert.visible = false
	fishSpin.visible = true
