# This script is an autoload, that can be accessed from any other script!
extends Node2D
# Signals
signal player_data_changed
signal fire_attack(type: String)
signal weapon_updated

# Player Data
var god : bool = false
var score : int = 0
var hp    : int = 100
var life  : int = 3
var max_hp  :int = 100
var max_life : int = 3
var default_score : int = 0
var default_hp : int = 100
var default_life : int = 3
var default_max_hp : int = 100
var default_max_life : int = 3
var player_starting_position : Vector2
# Sound Settings
var sfx_on := true
var music_on := true
var player : Player = null
var first_level : String = "res://_Scenes/Levels/game_levels/level_1.tscn"
var current_level : String
var save_path := "user://game.save"

const NON_SAVE_SCENES := [
	"res://_Scenes/Levels/UI/game_over.tscn",
	"res://_Scenes/Levels/UI/game_win.tscn",
	"res://_Scenes/Levels/menu.tscn",
]

# Modify player data
func add_score(value: int = 1):
	score += value
	player_data_changed.emit()

func add_hp(value: int = 1):
	if hp < max_hp:
		hp += value
	player_data_changed.emit()

func add_life():
	if life < max_life:
		life += 1
	player_data_changed.emit()
	
func add_weapon():
	weapon_updated.emit()

func load_level(scene: PackedScene):
	SceneTransition.load_scene(scene)
	current_level = scene.resource_path
	if scene.resource_path not in NON_SAVE_SCENES:
		save_game()
		#print("Saved new Checkpoint: ", current_level)

func full_restart():
	score = default_score
	hp = default_hp
	life = default_life
	max_hp = default_max_hp
	max_life = default_max_life
	load_level(load(first_level))

func level_restart():
	load_game()

func damage(value = 1):
	hp -= value
	if hp <= 0:
		death()

func update_option():
	var music_bus = AudioServer.get_bus_index("music")
	var sfx_bus = AudioServer.get_bus_index("sfx")
	AudioServer.set_bus_mute(sfx_bus, !sfx_on)
	AudioServer.set_bus_mute(music_bus, !music_on)

func death():
	if player != null:
		await player.death_tween()
	life -= 1
	player_data_changed.emit()
	if life <= 0:
		get_tree().change_scene_to_file("res://_Scenes/Levels/UI/game_over.tscn")

func save_option():
	var file = FileAccess.open("user://option.json", FileAccess.WRITE)
	if file:
		var payload: Dictionary = {
			"music": music_on,
			"sound": sfx_on,
		}
		var json_text = JSON.stringify(payload, "  ")
		file.store_pascal_string(json_text)
		file.close()

func load_option():
	if FileAccess.file_exists("user://option.json"):
		var file = FileAccess.open("user://option.json", FileAccess.READ)
		var text = file.get_pascal_string()
		file.close()

		var data = JSON.parse_string(text)
		if data == null:
			push_warning("option.json parse failed, using defaults")
			update_option()
			return

		music_on = data.get("music", true)
		sfx_on = data.get("sound", true)
		update_option()

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		var payload: Dictionary = {
			"current_level": current_level,
			"score": score,
			"life": life
		}
		var json_text = JSON.stringify(payload, "  ")
		file.store_pascal_string(json_text)
		file.close()

func has_gamesaved():
	return FileAccess.file_exists(save_path)

func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var text = file.get_pascal_string()
		file.close()

		var data = JSON.parse_string(text)
		if data == null:
			push_warning("game.save parse failed, doing full_restart instead")
			full_restart()
			return
		current_level = data.get("current_level", first_level)
		score = data.get("score", default_score)
		life = data.get("life", default_life)
		load_level(load(current_level))
	else:
		full_restart()

func attack(type: String):
	fire_attack.emit(type)
