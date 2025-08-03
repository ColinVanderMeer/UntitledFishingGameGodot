extends Control

var current_selection = 0

var rod_price = 500
var bait_price = 500
var luck_price = 500


func _process(_delta):
	if $Shop.visible && Global.interact:
	#if true:
		if Input.is_action_just_pressed("ui_up"):
			current_selection -= 1
			if current_selection < 0:
				current_selection = 3
		if Input.is_action_just_pressed("ui_down"):
			current_selection += 1
			if current_selection > 3:
				current_selection = 0
		if Input.is_action_just_pressed("interact"):
			await Engine.get_main_loop().process_frame
			await Engine.get_main_loop().process_frame
			match current_selection:
				0:
					if Global.player_money >= rod_price && rod_price != 0:
						Global.player_money -= rod_price
						Global.catch_speed_increase += 1
				1:
					if Global.player_money >= bait_price && bait_price != 0:
						Global.player_money -= bait_price
						Global.weight_increase += 1
				2:
					if Global.player_money >= luck_price && luck_price != 0:
						Global.player_money -= luck_price
						Global.rarity_increase += 1
				3:
					Global.player_money += 2000
					$Shop.visible = false
					Global.interact = false
		
		$Shop/Selector.position[1] = 20 + 30 * current_selection
		
		$Shop/MoneyCounter.text = str(Global.player_money)
		
		rod_price = 500 + Global.catch_speed_increase * 500
		$Shop/RodLabel/RodCost.text = str(rod_price)
		$Shop/RodLabel/RodHave.text = str(Global.catch_speed_increase)
		if Global.catch_speed_increase == 5:
			rod_price = 0
			$Shop/RodLabel/RodCost.text = ""
			$Shop/RodLabel/RodHave.text = ""
			$Shop/RodLabel.text = "Buy Rod Upgrade\n    Sold Out"
			
		bait_price = 500 + Global.weight_increase * 500
		$Shop/BaitLabel/BaitCost.text = str(bait_price)
		$Shop/BaitLabel/BaitHave.text = str(Global.weight_increase)
		if Global.weight_increase == 5:
			bait_price = 0
			$Shop/BaitLabel/BaitCost.text = ""
			$Shop/BaitLabel/BaitHave.text = ""
			$Shop/BaitLabel.text = "Buy Bait Upgrade\n    Sold Out"
			
		luck_price = 500 + Global.rarity_increase * 500
		$Shop/LuckLabel/LuckCost.text = str(luck_price)
		$Shop/LuckLabel/LuckHave.text = str(Global.rarity_increase)
		if Global.rarity_increase == 5:
			luck_price = 0
			$Shop/LuckLabel/LuckCost.text = ""
			$Shop/LuckLabel/LuckHave.text = ""
			$Shop/LuckLabel.text = "Buy Luck Upgrade\n    Sold Out"
