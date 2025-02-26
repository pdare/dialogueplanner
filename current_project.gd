extends Node

@onready var save_file_diag : FileDialog = $SaveGameDialogue

var characters : Dictionary
var scenes_dict : Dictionary
var save_dict : Dictionary
var save_location : String = 'user://Saves/'
var project_name : String = ''
var last_active_scene : String = ''
var path : String = ''

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func save_project() -> void:
	if project_name == '':
		save_file_diag.visible = true
	else:
		var temp_list : PackedStringArray = path.split('\\')
		var temp_proj_name : String
		
		for item in temp_list:
			if item.contains('.json'):
				temp_proj_name = item.replace('.json', '')
				break
		project_name = temp_proj_name
		print(scenes_dict)
		save_dict['Characters'] = characters
		save_dict['Scenes'] = scenes_dict
		save_dict['ProjectName'] = project_name
		save_dict['LastActive'] = last_active_scene
	
		var save_file : FileAccess = FileAccess.open(path, FileAccess.WRITE)
		save_file.store_string(JSON.stringify(save_dict, '\t'))

func _on_save_game_dialogue_file_selected(path: String) -> void:
	var temp_list : PackedStringArray = path.split('\\')
	var temp_proj_name : String
	
	for item in temp_list:
		if item.contains('.json'):
			temp_proj_name = item.replace('.json', '')
			break
	project_name = temp_proj_name
	print(scenes_dict)
	save_dict['Characters'] = characters
	save_dict['Scenes'] = scenes_dict
	save_dict['ProjectName'] = project_name
	save_dict['LastActive'] = last_active_scene
	
	
	var save_file : FileAccess = FileAccess.open(path, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(save_dict, '\t'))
