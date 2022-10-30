extends CanvasLayer

var global : Global = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Events").pauze.connect(_on_pauze)
	get_node("/root/Events").config_loaded.connect(_on_config_loaded)
	global = get_node("/root/Global")

	_setUiComponents()
	
	pass 

func _setUiComponents() -> void:
	print(global.config_data['volume_fx'])
	print(get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicSlider").value)
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicSlider").value = global.config_data['volume_music']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Fx/FxSlider").value = global.config_data['volume_fx']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Ui/UiSlider").value = global.config_data['volume_ui']
	print(get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicSlider").value)
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicMute").button_pressed = global.config_data['mute_music']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Fx/FxMute").button_pressed = global.config_data['mute_fx']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Ui/UiMute").button_pressed = global.config_data['mute_ui']
	
	get_node("Settings/Panel/Config/Settings/Display/Screen/FullScreen").button_pressed = global.config_data['fullscreen']
	get_node("Settings/Panel/Config/Settings/Display/Screen/Fps").button_pressed = global.config_data['fps']
	get_node("Settings/Panel/Config/Settings/Display/Screen/Vsync").button_pressed = global.config_data['vsync']
	
	pass
	
	
func _on_config_loaded() -> void:
	_setUiComponents()

func _on_pauze(state: bool) -> void:
	self.set_visible(state)
	if state == false:
		get_node("/root/Save")._save_settings()
	else:
		get_node("/root/Events").on_play_music("MenuMusic")
	pass

func _on_music_slider_value_changed(value: float) -> void:
	global.config_data['volume_music'] = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), value)
	pass


func _on_music_mute_toggled(button_pressed: bool) -> void:
	global.config_data['mute_music'] = button_pressed
	AudioServer.set_bus_mute(AudioServer.get_bus_index("music"), button_pressed)
	pass 


func _on_full_screen_toggled(button_pressed: bool)-> void:
	if(button_pressed):
		global.config_data['fullscreen'] = true
		get_tree().root.mode = Window.MODE_FULLSCREEN
	else: 
		global.config_data['fullscreen'] = false
		get_tree().root.mode = Window.MODE_WINDOWED
	pass 


func _on_back_pressed() -> void:
	get_node("/root/Save")._save_settings()
	$Settings.visible = false
	$Main.visible = true
	pass


func _on_exit_pressed():
	get_node("/root/Save")._save_settings()
	get_tree().quit()
	pass


func _on_settings_pressed():
	$Settings.visible = true
	$Main.visible = false
	pass # Replace with function body.

func _on_vsync_toggled(button_pressed):
	if(button_pressed):
		global.config_data['vsync'] = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else: 
		global.config_data['vsync'] = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	pass 


func _on_fps_toggled(button_pressed):
	global.config_data['fps'] = button_pressed
	get_node("/root/Events").on_fps_displayed(button_pressed)
	pass


func _on_fx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("fx"), value)
	global.config_data['volume_fx'] = value
	pass


func _on_fx_mute_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("fx"), button_pressed)
	global.config_data['mute_fx'] = button_pressed
	pass


func _on_ui_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ui"), value)
	global.config_data['volume_ui'] = value
	pass


func _on_ui_mute_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("ui"), button_pressed)
	global.config_data['mute_ui'] = button_pressed
	pass