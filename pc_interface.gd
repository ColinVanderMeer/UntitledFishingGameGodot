extends Control

var current_selection_h = 0
var current_selection_v = 0

var current_selection_display = 0
var current_selection = 0

func _process(_delta):
	if $FishList.visible && Global.interact:
	#if true:
		if Input.is_action_just_pressed("ui_up"):
			current_selection_v -= 1
			if current_selection_v < 0:
				current_selection_v = 3
		if Input.is_action_just_pressed("ui_down"):
			current_selection_v += 1
			if current_selection_v > 3:
				current_selection_v = 0
		if Input.is_action_just_pressed("ui_left"):
			current_selection_h -= 1
			if current_selection_h < 0:
				current_selection_h = 3
		if Input.is_action_just_pressed("ui_right"):
			current_selection_h += 1
			if current_selection_h > 3:
				current_selection_h = 0
		if Input.is_action_just_pressed("interact"):
			await Engine.get_main_loop().process_frame
			current_selection = current_selection_h + current_selection_v * 4
			
			if current_selection == 15:
				$FishList.visible = false
				Global.interact = false
				return
			
			if Global.fish_max_weight[current_selection] != 0:
				print("unlocked!!")
				var fish_info = Global.fish_data[current_selection]
				
				$FishInfoDisplay/Fish.texture = load(fish_info.texture)
				$FishInfoDisplay/FishDescription.text = fish_info.description
				$FishInfoDisplay/MaxWeight.text = "%.2f Kg" % [Global.fish_max_weight[current_selection]]
				
				$FishList.visible = false
				$FishInfoDisplay.visible = true
		
		$FishList/Selector.position[0] = 10 + current_selection_h * 36
		$FishList/Selector.position[1] = 2 + current_selection_v * 30
	else:
		current_selection_h = 0
		current_selection_v = 0
	
	if $FishInfoDisplay.visible && Global.interact:
		if Input.is_action_just_pressed("ui_up"):
			current_selection_display -= 1
			if current_selection_display < 0:
				current_selection_display = 3
		if Input.is_action_just_pressed("ui_down"):
			current_selection_display += 1
			if current_selection_display > 3:
				current_selection_display = 0
				
		if Input.is_action_just_pressed("interact"):	
			await Engine.get_main_loop().process_frame		
			match current_selection_display:
				0:
					Global.fish_display_fish[0] = current_selection
				1:
					Global.fish_display_fish[1] = current_selection
				2:
					Global.fish_display_fish[2] = current_selection
				3:
					$FishInfoDisplay.visible = false
					$FishList.visible = true
		
		$FishInfoDisplay/Selector.position[1] = 86 + current_selection_display * 10
	else:
		current_selection_display = 0
				
