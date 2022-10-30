@tool
extends TextureButton
class_name MenuBaseButton

@export var label : String = "Button":
	set (value):
		label = on_label_change(value)
	get:
		return label

func on_label_change(value: String) -> String:
	$Label.text  = value
	return value
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	$Click.play()
	pass # Replace with function body.
