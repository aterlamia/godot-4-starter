extends Node

#random key for encryption, keep in mind when exporting to web
# every user can see this key
var _key                      = 'random key'
var global: Global            = null
var events: Events            = null
var logs: Log                 = null
const _userfolder: String     = "user://"
const _datafolder: String     = "savedata"
const _settingsFolder: String = "settings"
const _saveFile: String       = ".save.save"
const _settingsfile: String   = _settingsFolder + "/settings.save"

var activeSlot: int = 0:
	get:
		return activeSlot
	set(value):
		activeSlot = value


func _ready() -> void:
	# This is a utility class, no processing needed so turn off processing
	set_process(false)
	set_physics_process(false)
	global = get_node("/root/Global")
	events = get_node("/root/Events")
	logs =  get_node("/root/Log")
	pass


func _load_settings() -> void:
	var save_path: String = _userfolder + _settingsfile
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_settingsFolder, save_path)
	var file: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, _key)
	if file == null:
		logs.log_error("Settings file encryption key invalid.", Log.LogType.LOG_GENERAL)

	var data = file.get_var()
	if !data:
		return
	global.apply_config(data)
	events.on_config_loaded()


func _init_new_save_file(folder: String, savepath: String) -> void:
	var directory := DirAccess.open(_userfolder)
	directory.make_dir_recursive(folder)
	FileAccess.open_encrypted_with_pass(savepath, FileAccess.WRITE, _key)
	pass


func _save_settings() -> void:
	var save_path = _userfolder + _settingsfile
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_settingsFolder, save_path)
	var save_settings: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, _key)
	if save_settings == null:
		logs.log_error("Settings file encryption key invalid.", Log.LogType.LOG_GENERAL)

	save_settings.store_var(global.config_data)
	pass


func _save_game() -> void:
	var date: String      = Time.get_datetime_string_from_system()
	var save_path: String = _userfolder + _datafolder.path_join(str(activeSlot) + _saveFile)
	var data              = global.gamestate_startLevel
	data.date = date
	data.created = date
	data.clicks = global.game_state["clicks"]
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_datafolder, save_path)
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, _key)
	if save_game == null:
		logs.log_error("Game file encryption key invalid.", Log.LogType.LOG_GENERAL)

	save_game.store_var(data)
	pass


func loadSave(slot: int) -> void:
	var save_path: String = _userfolder +  _datafolder.path_join(str(slot) + _saveFile)
	if not FileAccess.file_exists(save_path):
		logs.log_error("Save file does not exist.", Log.LogType.LOG_GENERAL)
		return
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, _key)
	if save_game == null:
		logs.log_error("Game file encryption key invalid.", Log.LogType.LOG_GENERAL)
		return

	return save_game.get_var()
