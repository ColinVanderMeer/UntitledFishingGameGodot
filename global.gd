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
	fish_list.clown:        {"name": "Clown Fish", "weight": Vector2(0.2, 2.0), "texture": "res://assets/Fish/clown.png", "description": "A small, brightly colored reef fish often found living among sea anemones"},
	fish_list.cod:          {"name": "Cod", "weight": Vector2(0.5, 3.0), "texture": "res://assets/Fish/cod.png", "description": "A cold-water fish that thrives in deep seas and northern waters\nCod is prized for its mild flavor and is a key species in many global fisheries"},
	fish_list.salmon:       {"name": "Salmon", "weight": Vector2(1.0, 5.0), "texture": "res://assets/Fish/salmon.png", "description": "Known for its legendary upriver journeys, Salmon shows great determination in both migration and flavor"},
	fish_list.pufferfish:   {"name": "Pufferfish", "weight": Vector2(0.3, 1.5), "texture": "res://assets/Fish/pufferfish.png", "description": "This fish inflates to defend itself, surprising predators\nHandle with care"},
	fish_list.tuna:         {"name": "Tuna", "weight": Vector2(2.0, 10.0), "texture": "res://assets/Fish/tuna.png", "description": "A powerful and fast-swimming fish known to traverse great distances"},
	fish_list.sea_bass:     {"name": "Sea Bass", "weight": Vector2(1.5, 6.0), "texture": "res://assets/Fish/sea_bass.png", "description": "The most common catch of the day. Sea Bass is well-known for biting often… maybe too often"},
	fish_list.catfish:      {"name": "Catfish", "weight": Vector2(1.0, 8.0), "texture": "res://assets/Fish/catfish.png", "description": "Named for its whisker-like barbels, this bottom-dweller can grow surprisingly large"},

	fish_list.pig_fish:     {"name": "Pig Fish", "weight": Vector2(3.0, 12.0), "texture": "res://assets/Fish/pig_fish.png", "description": "This fish doesn't know how to get food for itself, but it has a whole school behind it giving it the best food they can"},
	fish_list.singing_fish: {"name": "Singing Fish", "weight": Vector2(1.0, 4.0), "texture": "res://assets/Fish/singing_fish.png", "description": "This fish is known all across the ocean for its incredible singing voice and hit line of rhythm games based off of its songs"},
	fish_list.machine_fish: {"name": "Machine Fish", "weight": Vector2(5.0, 15.0), "texture": "res://assets/Fish/machine_fish.png", "description": "This fish is extremely fast with some researchers claiming it's able to do something called a \"Slam Storage\" to boost to amazing speeds"},
	fish_list.drimp:        {"name": "Drimp", "weight": Vector2(0.5, 2.5), "texture": "res://assets/Fish/drimp.png", "description": "Drimp has been stated to be quite cruel to other fish in it's area, but is sought after for it's decorative properties.\n\"Wow, Drimp is doing very good this week\" - Stock Analysts"},
	fish_list.shark:        {"name": "Shark", "weight": Vector2(10.0, 50.0), "texture": "res://assets/Fish/shark.png", "description": "The apex predator of the sea\nBut this one kinda looks cute and cuddly"},

	fish_list.orpheus:      {"name": "Orpheus", "weight": Vector2(2.0, 6.0), "texture": "res://assets/Fish/orpheus.png", "description": "This curious dino is never found far from a computer"},
	fish_list.at_fish:      {"name": "@Fish", "weight": Vector2(0.1, 1.0), "texture": "res://assets/Fish/at_fish.png", "descripton": "The real ones are in fish-channel"},
	fish_list.magical_frog: {"name": "Magical Frog", "weight": Vector2(0.2, 0.8), "texture": "res://assets/Fish/magical_frog.png", "description": "This magical frog is stated to love games and loves to see more of them get made"}
}

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

var fish_times_caught = {
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

var all_fish_times_caught = 0

var fish_display_fish = [
	fish_list.clown,
	fish_list.clown,
	fish_list.clown
]

var catch_speed_increase = 0
var weight_increase = 0
var rarity_increase = 0

var player_save_data = [
	fish_max_weight,
	player_money,
	fish_times_caught,
	all_fish_times_caught,
	fish_display_fish,
	catch_speed_increase,
	weight_increase,
	rarity_increase
]

func save_data():
	player_save_data = [fish_max_weight, player_money, fish_times_caught, all_fish_times_caught, fish_display_fish, catch_speed_increase, weight_increase, rarity_increase]
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(player_save_data)
	file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		save_data()
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	player_save_data = file.get_var()
	# If the save file is not the correct length, reset it to prevent out of bounds errors
	if len(player_save_data) < 7:
		player_save_data = [fish_max_weight, player_money, fish_times_caught, all_fish_times_caught, fish_display_fish, catch_speed_increase, weight_increase, rarity_increase]
		save_data()
	file.close()
	
	fish_max_weight = player_save_data[0]
	player_money = player_save_data[1]
	fish_times_caught = player_save_data[2]
	all_fish_times_caught = player_save_data[3]
	fish_display_fish = player_save_data[4]
	catch_speed_increase = player_save_data[5]
	weight_increase = player_save_data[6]
	rarity_increase = player_save_data[7]
