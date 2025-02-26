extends Control

@export var new_proj : PackedScene

@onready var open_new_proj_diag : FileDialog = $OpenProjectDialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_project_btn_pressed() -> void:
	get_tree().change_scene_to_packed(new_proj)


func _on_load_project_btn_pressed() -> void:
	open_new_proj_diag.visible = true


func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_open_project_dialogue_file_selected(path: String) -> void:
	var json_as_text : String = FileAccess.get_file_as_string(path)
	CurrentProject.path = path
	CurrentProject.save_dict = JSON.parse_string(json_as_text)
	CurrentProject.characters = CurrentProject.save_dict['Characters']
	CurrentProject.project_name = CurrentProject.save_dict['ProjectName']
	CurrentProject.scenes_dict = CurrentProject.save_dict['Scenes']
	CurrentProject.last_active_scene = CurrentProject.save_dict['LastActive']
	
	get_tree().change_scene_to_packed(new_proj)
