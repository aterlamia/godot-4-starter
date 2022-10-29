extends Node

signal scene_done
signal scene_started
signal gameover
signal scene_restarted

var log

func _ready():
	# optionaly add logger
	self.log = get_node("/root/Log")
	pass

func on_scene_done(scene: int):
	# optionaly fire log when emitting signal
	self.log.log_info("Scene done: " + str(scene), log.LogType.LOG_SIGNAL)
	emit_signal("scene_done", scene)

func on_scene_started(scene: int):
	# optionaly fire log when emitting signal
	self.log.log_info("Scene started: " + str(scene), log.LogType.LOG_SIGNAL)
	emit_signal("scene_started", scene)

func on_scene_restarted(scene: int):
		# optionaly fire log when emitting signal
		self.log.log_info("Scene restarted: " + str(scene), log.LogType.LOG_SIGNAL)
		emit_signal("scene_restarted", scene)

func on_gameover(scene: int):
		# optionaly fire log when emitting signal
		self.log.log_info("Gameover: " + str(scene), log.LogType.LOG_SIGNAL)
		emit_signal("gameover", scene)
