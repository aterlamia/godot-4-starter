extends Node

var _key = 'random key'
var _save_id: int = 1
var _default_values: Dictionary = {
	_DATE_KEY: "-"
}

var _data : Dictionary= {}

const _userfolder: String = "user://"
const _datafolder: String = "savedata"
const _settingsFolder: String = "settings"
const _template: String = "save_%03d.save"
const _settingsfile: String = _settingsFolder + "/settings.save"
const _DATE_KEY: String = "LAST_WRITE_DATE_TIME"


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
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(savepath, FileAccess.WRITE, _key)
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

func _load_data() -> void:
	var save_path: String = _userfolder + _datafolder.path_join(_template % _save_id)
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_datafolder, save_path)
	var file: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, _key)
	if file == null:
		get_node("/root/Log").log_error("Save file encryption key invalid.", Log.LogType.LOG_GENERAL) 
	_data = file.get_var()


func _update_save_file() -> void:
	var save_path = _userfolder + _datafolder.path_join(_template % _save_id)
	if not FileAccess.file_exists(save_path):
		_init_new_save_file(_datafolder, save_path)
	var save_game: FileAccess = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, _key)
	assert(save_game != null, "Save file encryption key invalid.")
	save_game.store_var(_data)

func _unload() -> void:
	_data = {}
	_save_id = 1

func _delete_save(id: int) -> void:
	var save_path = _userfolder + _datafolder.path_join(_template % id)
	var directory := DirAccess.open(_userfolder)
	directory.remove(save_path)
	_unload()



func delete(slot: int) -> void:
	_delete_save(slot)

func load_save(slot: int) -> void:
	_save_id = slot
	_load_data()

func save_value(my_key: String, value) -> void:
	_data[my_key] = value
	_data[_DATE_KEY] = Time.get_datetime_string_from_system()
	_update_save_file()

func load_value(my_key: String):
	if _data.has(my_key):
		var loaded_value = _data[my_key]
		if loaded_value == null:
			return null
		return loaded_value
	else:
		return null

func get_last_write_date(save_slot: int) -> String:
	_save_id = save_slot
	_load_data()
	var date_and_time: String = load_value(_DATE_KEY)
	_unload()
	return date_and_time
