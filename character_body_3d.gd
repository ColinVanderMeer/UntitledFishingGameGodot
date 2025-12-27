extends CharacterBody3D

const SPEED = 5.0
const SNAP_THRESHOLD = 0.5 

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var sprite := $Neck/AnimatedSprite3D

@onready var xr_nodes = get_tree().get_nodes_in_group("XrNodes")[0]
@onready var left_controller: XRController3D = xr_nodes.get_node("LeftHand")
@onready var right_controller: XRController3D = xr_nodes.get_node("RightHand")

var can_snap_turn = true
var sprite_direction = "W"

func _ready():
	Global.save_data()

func _physics_process(delta: float) -> void:
	var rotation_input = right_controller.get_vector2("primary")
	
	if abs(rotation_input.x) > SNAP_THRESHOLD:
		if can_snap_turn:
			var turn_dir = -1 if rotation_input.x > 0 else 1
			neck.rotate_y(turn_dir * (PI / 4.0))
			can_snap_turn = false
			update_sprite_direction()
	else:
		can_snap_turn = true

	var joy_vector = left_controller.get_vector2("primary")
	var input_dir := Vector2.ZERO
	
	if joy_vector.length() > 0.1:
		input_dir = joy_vector

	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		set_animation("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		set_animation("Idle")

	if !Global.interact:
		move_and_slide()


func set_animation(animation_name: String):
	sprite.play(animation_name + sprite_direction)

func update_sprite_direction():
	var rot = wrapf(neck.rotation.y, 0, TAU)
	
	if rot >= 13.0*PI/8.0 or rot < 3.0*PI/8.0:
		sprite_direction = "W"
	elif rot >= 3.0*PI/8.0 and rot < 5.0*PI/8.0:
		sprite_direction = "D"
	elif rot >= 5.0*PI/8.0 and rot < 11.0*PI/8.0:
		sprite_direction = "S"
	else:
		sprite_direction = "A"
