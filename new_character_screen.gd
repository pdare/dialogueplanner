extends Control

signal added_character

@export var default_portrait : Texture2D

@onready var add_character_pic_btn : Button = $HBoxContainer/VBoxContainer/AddCharacterPic
@onready var file_diag : FileDialog = $FileDialog
@onready var character_portrait : TextureRect = $HBoxContainer/VBoxContainer/CharacterPortrait
@onready var character_name_edit : TextEdit = $HBoxContainer/VBoxContainer2/CharacterNameEdit

var portrait_file_path : String
var save_location : String = 'user://Saves/'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	file_diag.visible = true


func _on_file_dialog_file_selected(path: String) -> void:
	print(path)
	#var image := Image.load_from_file(path)
	#var texture := ImageTexture.create_from_image(image)
	character_portrait.texture = load(path)
	portrait_file_path = path


func _on_add_btn_pressed() -> void:
	var char_dict : Dictionary
	char_dict[character_name_edit.text.strip_edges()] = portrait_file_path
	
	CurrentProject.characters[character_name_edit.text.strip_edges()] = portrait_file_path
	added_character.emit(char_dict)
	char_dict = {}
	character_portrait.texture = default_portrait
	character_name_edit.clear()
