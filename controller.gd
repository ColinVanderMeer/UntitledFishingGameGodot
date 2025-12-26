extends XRController3D

func _on_button_pressed(action_name: String):
	print("Test")
	if action_name == "ax_button":
		var ev = InputEventAction.new()
		ev.action = "interact"
		ev.pressed = true
		Input.parse_input_event(ev)
		print("axpress")
	if action_name == "by_button":
		var ev = InputEventAction.new()
		ev.action = "MenuButton"
		ev.pressed = true
		Input.parse_input_event(ev)
		print("bypress")
	if action_name == "joy_left":
		var ev = InputEventAction.new()
		ev.action = "ui_left"
		ev.pressed = false
		Input.parse_input_event(ev)
		print("joyleft")
	if action_name == "joy_right":
		var ev = InputEventAction.new()
		ev.action = "ui_right"
		ev.pressed = false
		Input.parse_input_event(ev)
		print("joyright")
	if action_name == "joy_up":
		var ev = InputEventAction.new()
		ev.action = "ui_up"
		ev.pressed = false
		Input.parse_input_event(ev)
		print("joyup")
	if action_name == "joy_down":
		var ev = InputEventAction.new()
		ev.action = "ui_down"
		ev.pressed = false
		Input.parse_input_event(ev)
		print("joydown")

func _on_button_released(action_name: String):
	if action_name == "ax_button":
		var ev = InputEventAction.new()
		ev.action = "interact"
		ev.pressed = false
		Input.parse_input_event(ev)
	if action_name == "by_button":
		var ev = InputEventAction.new()
		ev.action = "MenuButton"
		ev.pressed = false
		Input.parse_input_event(ev)
	if action_name == "joy_left":
		var ev = InputEventAction.new()
		ev.action = "ui_left"
		ev.pressed = false
		Input.parse_input_event(ev)
	if action_name == "joy_right":
		var ev = InputEventAction.new()
		ev.action = "ui_right"
		ev.pressed = false
		Input.parse_input_event(ev)
	if action_name == "joy_up":
		var ev = InputEventAction.new()
		ev.action = "ui_up"
		ev.pressed = false
		Input.parse_input_event(ev)
	if action_name == "joy_down":
		var ev = InputEventAction.new()
		ev.action = "ui_down"
		ev.pressed = false
		Input.parse_input_event(ev)
