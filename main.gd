extends Control

@export var new_proj : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_project_btn_pressed() -> void:
	get_tree().change_scene_to_packed(new_proj)


func _on_load_project_btn_pressed() -> void:
	pass # Replace with function body.


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
