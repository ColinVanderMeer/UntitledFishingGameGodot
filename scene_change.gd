extends Area2D

enum direction_enum {North, East, South, West}

@export var interact_type = "scene_change"
@export var direction: direction_enum
@export_file("*.tscn") var map
