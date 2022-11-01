extends Node2D

var Logger := load("res://src/managers/log.gd")
@export_flags("LOG_ERROR","LOG_WARN", "LOG_INFO", "LOG_DEBUG") var log_level: int = Logger.LogSeverity.LOG_NONE
@export_flags("LOG_GENERAL","LOG_UI", "LOG_ENEMY", "LOG_PLAYER", "LOG_SIGNAL", "LOG_PATHFINDING", "LOG_INIT", "LOG_EXIT", "LOG_SCENE", "LOG_SOUND") var log_type: int = Logger.LogType.LOG_GENERAL

var log
var globals: Global = null
var events: Events = null
func _ready() -> void:
	get_node("/root/Save")._load_settings()
	globals = get_node("/root/Global")
	events = get_node("/root/Events")

	self.log = get_node("/root/Log")
	self.log.init(self.log_level, self.log_type)
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if !globals.in_game:
			return

		if event.is_action_pressed("ui_cancel") && !globals.pauzed:
			events.on_pauze(true)
			globals.pauzed = true
		elif event.is_action_pressed("ui_cancel"):
			events.on_pauze(false)
			globals.pauzed = false
	pass


func _process(delta: float) -> void:
	pass
  
