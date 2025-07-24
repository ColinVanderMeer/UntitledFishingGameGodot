extends CharacterBody2D

const SPEED = 70

var input_direction: get = _get_input_direction 
var sprite_direction = "S": get = _get_sprite_direction

@onready var sprite = $AnimatedSprite2D


func _physics_process(_delta):
	velocity = input_direction * SPEED
	move_and_slide()
	
	set_animation("Walk")
	if velocity == Vector2.ZERO:
		set_animation("Idle")


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
		Vector2.RIGHT:
			sprite_direction = "D"
		Vector2.UP:
			sprite_direction = "W"
		Vector2.DOWN:
			sprite_direction = "S"
	return sprite_direction
