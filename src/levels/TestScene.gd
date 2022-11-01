extends Node2D

var test: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func load() -> void:
	test = get_node("/root/Global").game_state['clicks']
	$Label.text = str(test)


func _process(delta) -> void:
	pass

func _on_button_pressed():
	test += 1
	# int to string
	
	$Label.text = str(test)

	# probbaly should just be a signal
	get_node("/root/Global").set_game_data(test, "clicks")
	if test == 10:
		get_node("/root/Events").on_gameover(1)
	pass # Replace with function body.
