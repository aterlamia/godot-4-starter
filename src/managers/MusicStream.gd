extends AudioStreamPlayer

@export var items : Dictionary

var log

# Called when the node enters the scene tree for the first time.
func _ready():
	self.log = get_node("/root/Log")
	get_node("/root/Events").play_music.connect(_play_music)
	pass # Replace with function body.

func _play_music(music):
	if music in items:
		self.stream = items[music]
		self.play()
		self.log.log_debug("Music playing: " + music, log.LogType.LOG_SOUNDS)
	else:
		self.log.log_error("Music not found: " + music, log.LogType.LOG_SOUNDS)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
