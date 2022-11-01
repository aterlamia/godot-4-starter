extends Node

var _key = 'random key'


const _userfolder: String = "user://"
const _datafolder: String = "savedata"
const _settingsFolder: String = "settings"
const _saveFile: String = ".save.save"
const _settingsfile: String = _settingsFolder + "/settings.save"

var activeSlot: int = 0 :
	get:
		return activeSlot
	set(value):
		activeSlot = value

func _load_settings() -> void:
	var save_path = _userfolder + _settingsfile
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_settingsFolder, save_path)
	var file: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, _key)
	if file == null:
		get_node("/root/Log").log_error("Settings file encryption key invalid.", Log.LogType.LOG_GENERAL) 
	get_node("/root/Global").apply_config(file.get_var())
	get_node("/root/Events").on_config_loaded()

func _init_new_save_file(folder:String, savepath: String) -> void:
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
		get_node("/root/Log").log_error("Settings file encryption key invalid.", Log.LogType.LOG_GENERAL) 
		
	save_settings.store_var(get_node("/root/Global").config_data)
	pass

func _save_game() -> void:
	var date =  Time.get_datetime_string_from_system()
	var save_path = _userfolder + _datafolder.path_join(activeSlot + _saveFile)
	var data = get_node("/root/Global").game_state
	data.date = date	
	data.created = date

	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_datafolder, save_path)
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, _key)
	if save_game == null:
		get_node("/root/Log").log_error("Game file encryption key invalid.", Log.LogType.LOG_GENERAL) 
		
	save_game.store_var(get_node("/root/Global").game_state)
	pass

func loadSave(slot: int):
	var save_path = _userfolder +  _datafolder.path_join(slot + _saveFile)
	if not FileAccess.file_exists(save_path):
		get_node("/root/Log").log_error("Save file does not exist.", Log.LogType.LOG_GENERAL) 
		return
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, _key)
	if save_game == null:
		get_node("/root/Log").log_error("Game file encryption key invalid.", Log.LogType.LOG_GENERAL) 
		return
	
	return save_game.get_var()
