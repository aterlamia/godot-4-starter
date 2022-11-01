extends Node

signal pauze
signal game_started
signal scene_done
signal scene_started
signal gameover
signal scene_restarted
signal play_music
signal fps_displayed
signal config_loaded

var log

func _ready() -> void: 
	# optionaly add logger
	self.log = get_node("/root/Log")
	pass

func on_game_started(state: bool)  -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Started " + ("True" if state else "False"), log.LogType.LOG_SIGNAL)
	emit_signal("game_started", state)

func on_pauze(state: bool)  -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Pauze " + ("True" if state else "False"), log.LogType.LOG_SIGNAL)
	emit_signal("pauze", state)


func on_config_loaded()  -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Config loaded", log.LogType.LOG_SIGNAL)
	emit_signal("config_loaded")

func on_fps_displayed(state: bool)  -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Showfps " + ("True" if state else "False"), log.LogType.LOG_SIGNAL)
	emit_signal("fps_displayed", state)


func on_play_music(name: String) -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("play_music: " + name, log.LogType.LOG_SIGNAL)
	emit_signal("play_music", name)


func on_scene_done(scene: int) -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Scene done: " + str(scene), log.LogType.LOG_SIGNAL)
	emit_signal("scene_done", scene)

func on_scene_started(scene: int) -> void: 
	# optionaly fire log when emitting signal
	self.log.log_info("Scene started: " + str(scene), log.LogType.LOG_SIGNAL)
	emit_signal("scene_started", scene)

func on_scene_restarted(scene: int) -> void: 
		# optionaly fire log when emitting signal
		self.log.log_info("Scene restarted: " + str(scene), log.LogType.LOG_SIGNAL)
		emit_signal("scene_restarted", scene)

func on_gameover(scene: int) -> void: 
		# optionaly fire log when emitting signal
		self.log.log_info("Gameover: " + str(scene), log.LogType.LOG_SIGNAL)
		emit_signal("gameover", scene)
