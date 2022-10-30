extends Node

enum LogSeverity {
	LOG_NONE = 0,
	LOG_ERROR = 1,
	LOG_WARN = 2,
	LOG_INFO = 4,
	LOG_DEBUG = 8,
	LOG_ALL = 8 + 4 + 2 + 1
};

enum LogType {
	LOG_GENERAL = 1,
	LOG_UI = 2,
	LOG_ENEMY = 4,
	LOG_PLAYER = 8,
	LOG_SIGNAL = 16,
	LOG_PATHFINDING = 32,
	LOG_INIT = 64,
	LOG_EXIT = 128,
	LOG_SCENE = 256,
	LOG_SOUNDS = 512,
	LOG_ALL = 512 + 256 + 128 + 64 + 32 + 16 + 8 + 4 + 2 + 1
};

var log_severity = LogSeverity.LOG_ALL
var log_type = LogType.LOG_ALL

func init(log_level, log_type):
	self.log_severity = log_level
	self.log_type = log_type

# Get the severity name based on the severity value
func get_severity_name(severity):
	match severity:

		LogSeverity.LOG_ERROR:
			return "ERROR"
		LogSeverity.LOG_WARN:
			return "WARNING"
		LogSeverity.LOG_INFO:
			return "INFORMATION"
		LogSeverity.LOG_DEBUG:
			return "DEBUG"
		LogSeverity.LOG_ALL:
			return "ALL LOGS"
		_:
			return "NONE"
	

	# Get the type name based	on the type value
func get_type_name(type): 
	match type:
		LogType.LOG_UI:
			return "Ui"
		LogType.LOG_ENEMY:
			return "Enemy"
		LogType.LOG_PLAYER:
			return "Player"
		LogType.LOG_SIGNAL:
			return "Signal"
		LogType.LOG_PATHFINDING:
			return "Pathfinding"
		LogType.LOG_INIT:
			return "Init"
		LogType.LOG_EXIT:
			return "Exit"
		LogType.LOG_SCENE:
			return "Scenes"
		LogType.LOG_SOUNDS:
			return "Sounds & Music"

		LogType.LOG_ALL:
			return "All types"
		_:
			return "NONE"

func log_error(message: String, type:=LogType.LOG_GENERAL):
	if self.log_type & type:
		self.print_log(message, LogSeverity.LOG_ERROR, type)

func log_warning(message: String, type:=LogType.LOG_GENERAL):
	if self.log_type & type:
		self.print_log(message, LogSeverity.LOG_WARN, type)

func log_info(message: String, type:=LogType.LOG_GENERAL):
	if self.log_type & type:
		self.print_log(message, LogSeverity.LOG_INFO, type)

func log_debug(message: String, type:=LogType.LOG_GENERAL):
	if self.log_type & type:
		self.print_log(message, LogSeverity.LOG_DEBUG, type)

func print_log(message:String, severity:=LogSeverity.LOG_ERROR, type:=LogType.LOG_GENERAL):
		if self.log_severity & severity && self.log_type & type:
			print(get_severity_name(severity) , "(", get_type_name(type) , "): ", message)
