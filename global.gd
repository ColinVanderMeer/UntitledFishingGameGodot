extends Node

const SAVE_FILE ="user://save_file.save"

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

var player_save_data = [
	fish_max_weight,
	player_money
]

var player_money = 0

var fish_max_weight = {
	fish_list.clown: 0,
	fish_list.cod: 0,
	fish_list.salmon: 0,
	fish_list.pufferfish: 0,
	fish_list.tuna: 0,
	fish_list.sea_bass: 0,
	fish_list.catfish: 0,

	fish_list.pig_fish: 0,
	fish_list.singing_fish: 0,
	fish_list.machine_fish: 0,
	fish_list.drimp: 0,
	fish_list.shark: 0,

	fish_list.orpheus: 0,
	fish_list.at_fish: 0,
	fish_list.magical_frog: 0
}

func save_data():
	player_save_data = [fish_max_weight, player_money]
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(player_save_data)
	file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		save_data()
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	player_save_data = file.get_var()
	# If the save file is not the correct length, reset it to prevent out of bounds errors
	if len(player_save_data) < 1:
		player_save_data = [fish_max_weight, player_money]
		save_data()
	file.close()
	
	fish_max_weight = player_save_data[0]
	player_money = player_save_data[1]
