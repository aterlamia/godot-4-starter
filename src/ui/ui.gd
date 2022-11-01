extends CanvasLayer

var global : Global = null
var save  : Save  = null
var new_game_slot = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/Events").pauze.connect(_on_pauze)
	get_node("/root/Events").game_started.connect(_on_game_started)
	get_node("/root/Events").config_loaded.connect(_on_config_loaded)
	global = get_node("/root/Global")
	save = get_node("/root/Save")
	_setUiComponents()
	
	pass 

func _setUiComponents() -> void:
	# set the volume values
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicSlider").value = global.config_data['volume_music']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Fx/FxSlider").value = global.config_data['volume_fx']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Ui/UiSlider").value = global.config_data['volume_ui']

	# set the mute values
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Music/MusicMute").button_pressed = global.config_data['mute_music']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Fx/FxMute").button_pressed = global.config_data['mute_fx']
	get_node("Settings/Panel/Config/Settings/Sound/Sound/Ui/UiMute").button_pressed = global.config_data['mute_ui']
	
	#set the display values
	get_node("Settings/Panel/Config/Settings/Display/Screen/FullScreen").button_pressed = global.config_data['fullscreen']
	get_node("Settings/Panel/Config/Settings/Display/Screen/Fps").button_pressed = global.config_data['fps']
	get_node("Settings/Panel/Config/Settings/Display/Screen/Vsync").button_pressed = global.config_data['vsync']
	
	pass
	
	
func _on_game_started(started) -> void:
	if started:
		get_node("Main/Control/VBoxContainer/NewGame").visible = false
		get_node("Main/Control/VBoxContainer/Continue").visible = false
		get_node("Main/Control/VBoxContainer/Save").visible = true
	else:
		get_node("Main/Control/VBoxContainer/NewGame").visible = true
		get_node("Main/Control/VBoxContainer/Continue").visible = true
		get_node("Main/Control/VBoxContainer/Save").visible = false
	pass

func _on_config_loaded() -> void:
	_setUiComponents()
	
func _on_pauze(state: bool) -> void:
	self.set_visible(state)
	if state == false:
		save._save_settings()
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
	save._save_settings()
	resetToMain()
	pass


func _on_exit_pressed() -> void:
	save._save_settings()
	get_tree().quit()
	pass


func _on_settings_pressed() -> void:
	$Settings.visible = true
	$Main.visible = false
	pass # Replace with function body.

func _on_vsync_toggled(button_pressed) -> void:
	if(button_pressed):
		global.config_data['vsync'] = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else: 
		global.config_data['vsync'] = true
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	pass 


func _on_fps_toggled(button_pressed) -> void:
	global.config_data['fps'] = button_pressed
	get_node("/root/Events").on_fps_displayed(button_pressed)
	pass


func _on_fx_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("fx"), value)
	global.config_data['volume_fx'] = value
	pass


func _on_fx_mute_toggled(button_pressed) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("fx"), button_pressed)
	global.config_data['mute_fx'] = button_pressed
	pass


func _on_ui_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ui"), value)
	global.config_data['volume_ui'] = value
	pass

func _on_ui_mute_toggled(button_pressed) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("ui"), button_pressed)
	global.config_data['mute_ui'] = button_pressed
	pass

func _on_new_game_pressed() -> void:
	hideAll()
	for i in range(1, 5):
		var save_data = save.loadSave(i)
		if save_data != null:
			setNewData(i, save_data)
	$NewGame.visible = true
	pass

func _on_save_pressed():
	save._save_game()
	pass


func hideAll():
	$Settings.visible = false
	$Main.visible = false
	$Load.visible = false
	$HowToPlay.visible = false
	$NewGame.visible = false

func resetToMain():
	hideAll()
	$Main.visible = true
	pass

func _on_load_pressed():
	hideAll()
	$Load.visible = true

	for i in range(1, 5):
		var save_data = save.loadSave(i)
		if save_data != null:
			setSaveData(i, save_data)
	pass 


func setSaveData(slot: int, save_data) -> void:
	var panel = get_node("Load/NinePatchRect/Save%s/SavePanel" % slot)
	panel.get_node("NoSave").visible = false
	panel.get_node("Save").visible = true
	panel.get_node("Save/LvlVal").text = str(save_data['level'])
	panel.get_node("Save/clickVal").text = str(save_data['clicks'])
	panel.get_node("Save/playtimeVal").text = save_data['date']
	panel.get_node("Save/dateSavedVal").text = save_data['created']
	
	pass 

func setNewData(slot: int, save_data) -> void:
	var panel = get_node("NewGame/NinePatchRect/Save%s/SavePanel" % slot)
	panel.get_node("NoSave").visible = false
	panel.get_node("Save").visible = true
	panel.get_node("Save/LvlVal").text = str(save_data['level'])
	panel.get_node("Save/clickVal").text = str(save_data['clicks'])
	panel.get_node("Save/playtimeVal").text = save_data['date']
	panel.get_node("Save/dateSavedVal").text = save_data['created']
	
	pass 
	
func _on_load_save_pressed(extra_arg_0):
	var save_data = save.loadSave(extra_arg_0)
	if save_data != null:
		global.set_game_data(save_data['level'], "level")
		global.set_game_data(save_data['clicks'], "clicks")
		get_node("/root/Events").on_scene_restarted(save_data['level'])
		get_node("/root/Events").on_game_started(true)
		save.activeSlot = extra_arg_0
		self.set_visible(false)
		global.in_game = true
		resetToMain()
	pass # Replace with function body.

func _on_new_save_pressed(extra_arg_0):
	var save_data = save.loadSave(extra_arg_0)
	if save_data != null:
		new_game_slot = extra_arg_0
		get_node("NewGame/NinePatchRect/Sure").visible = true
		return
		
	global.set_game_data(1, "level")
	global.set_game_data(0, "clicks")
	get_node("/root/Events").on_scene_restarted(1)
	get_node("/root/Events").on_game_started(true)
	save.activeSlot = extra_arg_0
	self.set_visible(false)
	global.in_game = true
	resetToMain()
	save._save_game()
	pass # Replace with function body.
	
func _on_ok_pressed():
	var save_data = save.loadSave(new_game_slot)
	if save_data != null:
		global.set_game_data(1, "level")
		global.set_game_data(0, "clicks")
		get_node("/root/Events").on_scene_restarted(1)
		get_node("/root/Events").on_game_started(true)
		save.activeSlot = new_game_slot
		self.set_visible(false)
		global.in_game = true
		resetToMain()
		new_game_slot = 0
		get_node("NewGame/NinePatchRect/Sure").visible = false
		save._save_game()
	pass # Replace with function body.


func _on_cancel_pressed():
	get_node("NewGame/NinePatchRect/Sure").visible = false
	new_game_slot = 0
	pass # Replace with function body.
