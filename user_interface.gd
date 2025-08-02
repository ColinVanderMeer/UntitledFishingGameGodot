extends Control

var current_selection = 0

func _process(_delta):
	if $Menu.visible && Global.interact:
	#if true:
		if Input.is_action_just_pressed("ui_up"):
			current_selection -= 1
			if current_selection < 0:
				current_selection = 2
		if Input.is_action_just_pressed("ui_down"):
			current_selection += 1
			if current_selection > 2:
				current_selection = 0
		if Input.is_action_just_pressed("interact"):
			match current_selection:
				0:
					Global.save_data()
					$Menu.visible = false
					Global.interact = false
				1:
					Global.load_data()
					$Menu.visible = false
					Global.interact = false
				2:
					$Menu.visible = false
					Global.interact = false
		
		$Menu/Selector.position[1] = 15 + 10 * current_selection

	if Input.is_action_just_pressed("MenuButton"):
		if !Global.interact:
			$Menu/MoneyCounter.text = str(Global.player_money)
			$Menu.visible = true
			Global.interact = true
