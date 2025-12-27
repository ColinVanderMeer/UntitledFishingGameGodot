extends XRController3D

func _on_button_pressed(action_name: String):
	if action_name == "ax_button":
		Input.action_press("interact")
	if action_name == "by_button":
		Input.action_press("MenuButton")

func _on_button_released(action_name: String):
	if action_name == "ax_button":
		Input.action_release("interact")
	if action_name == "by_button":
		Input.action_release("MenuButton")

func _on_input_vector_2_changed(name: String, value: Vector2):
	if value.y > 0.7:
		Input.action_press("ui_up")
	elif Input.is_action_pressed("ui_up"):
		Input.action_release("ui_up")

	if value.y < -0.7:
		Input.action_press("ui_down")
	elif Input.is_action_pressed("ui_down"):
		Input.action_release("ui_down")

	if value.x > 0.7:
		Input.action_press("ui_right")
	elif Input.is_action_pressed("ui_right"):
		Input.action_release("ui_right")

	if value.x < -0.7:
		Input.action_press("ui_left")
	elif Input.is_action_pressed("ui_left"):
		Input.action_release("ui_left")
