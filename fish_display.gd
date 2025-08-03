extends Area2D

@export var interact_type = "fish_display"
@export var frame_num: int

func _process(_delta):
	$Frame/Fish.texture = load(Global.fish_data[Global.fish_display_fish[frame_num]].texture)
