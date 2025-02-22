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
var logger :Log

func _ready() -> void:
	logger = get_node("/root/Log")
	# This is a listener, no processing needed so turn off processing
	set_process(false)
	set_physics_process(false)

	pass

func on_game_started(state: bool)  -> void:
	logger.log_info("Started " + ("True" if state else "False"), logger.LogType.LOG_SIGNAL)
	emit_signal("game_started", state)

func on_pauze(state: bool)  -> void:
	logger.log_info("Pauze " + ("True" if state else "False"), logger.LogType.LOG_SIGNAL)
	emit_signal("pauze", state)

func on_config_loaded()  -> void:
	logger.log_info("Config loaded", logger.LogType.LOG_SIGNAL)
	emit_signal("config_loaded")

func on_fps_displayed(state: bool)  -> void:
	logger.log_info("Showfps " + ("True" if state else "False"), logger.LogType.LOG_SIGNAL)
	emit_signal("fps_displayed", state)

func on_play_music(musicName: String) -> void:
	logger.log_info("play_music: " + musicName, logger.LogType.LOG_SIGNAL)
	emit_signal("play_music", musicName)

func on_scene_done(scene: int) -> void:
	logger.log_info("Scene done: " + str(scene), logger.LogType.LOG_SIGNAL)
	emit_signal("scene_done", scene)

func on_scene_started(scene: int) -> void:
	logger.log_info("Scene started: " + str(scene), logger.LogType.LOG_SIGNAL)
	emit_signal("scene_started", scene)

func on_scene_restarted(scene: int) -> void:
	logger.log_info("Scene restarted: " + str(scene), logger.LogType.LOG_SIGNAL)
	emit_signal("scene_restarted", scene)

func on_gameover(scene: int) -> void:
	logger.log_info("Gameover: " + str(scene), logger.LogType.LOG_SIGNAL)
	emit_signal("gameover", scene)
