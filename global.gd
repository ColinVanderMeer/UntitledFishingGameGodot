extends Node

var interact = false # I should add a punch card...
var player_spawn_position = Vector2.ZERO

enum fish_list {
	clown, cod, salmon, pufferfish, tuna, sea_bass, catfish,
	pig_fish, singing_fish, machine_fish, drimp, shark,
	orpheus, at_fish, magical_frog
}

# Dictionary for all fish data
var fish_data = {
	fish_list.clown:        {"name": "Clown Fish", "weight": Vector2(0.2, 2.0), "texture": "res://assets/Fish/clown.png"},
	fish_list.cod:          {"name": "Cod", "weight": Vector2(0.5, 3.0), "texture": "res://assets/Fish/cod.png"},
	fish_list.salmon:       {"name": "Salmon", "weight": Vector2(1.0, 5.0), "texture": "res://assets/Fish/salmon.png"},
	fish_list.pufferfish:   {"name": "Pufferfish", "weight": Vector2(0.3, 1.5), "texture": "res://assets/Fish/pufferfish.png"},
	fish_list.tuna:         {"name": "Tuna", "weight": Vector2(2.0, 10.0), "texture": "res://assets/Fish/tuna.png"},
	fish_list.sea_bass:     {"name": "Sea Bass", "weight": Vector2(1.5, 6.0), "texture": "res://assets/Fish/sea_bass.png"},
	fish_list.catfish:      {"name": "Catfish", "weight": Vector2(1.0, 8.0), "texture": "res://assets/Fish/catfish.png"},

	fish_list.pig_fish:     {"name": "Pig Fish", "weight": Vector2(3.0, 12.0), "texture": "res://assets/Fish/pig_fish.png"},
	fish_list.singing_fish: {"name": "Singing Fish", "weight": Vector2(1.0, 4.0), "texture": "res://assets/Fish/singing_fish.png"},
	fish_list.machine_fish: {"name": "Machine Fish", "weight": Vector2(5.0, 15.0), "texture": "res://assets/Fish/machine_fish.png"},
	fish_list.drimp:        {"name": "Drimp", "weight": Vector2(0.5, 2.5), "texture": "res://assets/Fish/drimp.png"},
	fish_list.shark:        {"name": "Shark", "weight": Vector2(10.0, 50.0), "texture": "res://assets/Fish/shark.png"},

	fish_list.orpheus:      {"name": "Orpheus", "weight": Vector2(2.0, 6.0), "texture": "res://assets/Fish/orpheus.png"},
	fish_list.at_fish:      {"name": "@Fish", "weight": Vector2(0.1, 1.0), "texture": "res://assets/Fish/at_fish.png"},
	fish_list.magical_frog: {"name": "Magical Frog", "weight": Vector2(0.2, 0.8), "texture": "res://assets/Fish/magical_frog.png"}
}
