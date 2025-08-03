extends Interactable

func _process(_delta):
	self.interact_value = "Look at all those fishies\nYou've caught %d fishes so far" % Global.all_fish_times_caught
