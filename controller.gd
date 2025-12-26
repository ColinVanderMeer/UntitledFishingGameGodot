extends XRController3D

func _on_button_pressed(action_name: String):
	if action_name == "ax_button":
		var ev = InputEventAction.new()
		ev.action = "interact"
		ev.pressed = true
		Input.parse_input_event(ev)
	if action_name == "by_button":
		var ev = InputEventAction.new()
		ev.action = "MenuButton"
		ev.pressed = true
		Input.parse_input_event(ev)

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
