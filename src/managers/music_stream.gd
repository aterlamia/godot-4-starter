extends AudioStreamPlayer

@export var items : Dictionary

var logger: Log

# Called when the node enters the scene tree for the first time.
func _ready()  -> void:
	logger = get_node("/root/Log")
	get_node("/root/Events").play_music.connect(_play_music)
	
	# This is a listener, no processing needed so turn off processing
	set_process(false)
	set_physics_process(false)
	pass

func _play_music(musicName)  -> void:
	if musicName in items:
		stream = items[musicName]
		play()
		logger.log_debug("Music playing: " + musicName, logger.LogType.LOG_SOUNDS)
	else:
		logger.log_error("Music not found: " + musicName, logger.LogType.LOG_SOUNDS)

