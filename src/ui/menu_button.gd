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
	
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	$Click.play()
	pass # Replace with function body.
