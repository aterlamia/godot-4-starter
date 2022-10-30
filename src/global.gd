extends Node

var pauzed: bool = false

var config_data: Dictionary = {
	"fullscreen": false,
	"vsync": false,
	"fps": false,
	"mute_music": false,
	"mute_fx": false,
	"mute_ui": false,
	"volume_music": 0,
	"volume_ui": 0,
	"volume_fx": 0,
}

func apply_config(data: Dictionary):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("music"), data['mute_music'])
	AudioServer.set_bus_mute(AudioServer.get_bus_index("fx"), data['mute_fx'])
	AudioServer.set_bus_mute(AudioServer.get_bus_index("ui"), data['mute_ui'])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), data['volume_music'])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("fx"), data['volume_fx'])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("ui"), data['volume_ui'])

	if(data['vsync']):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			
	if(data['fullscreen']):
		get_tree().root.mode = Window.MODE_FULLSCREEN
	else:
		get_tree().root.mode = Window.MODE_WINDOWED
		
	get_node("/root/Events").on_fps_displayed(data['fps'])
	
	config_data = data
