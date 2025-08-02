extends TextureRect

@export var fish_type: Global.fish_list

func _process(_delta):
	if Global.fish_max_weight[fish_type] == 0:
		self.modulate = Color(0, 0, 0)
	else:
		self.modulate = Color(1, 1, 1)
