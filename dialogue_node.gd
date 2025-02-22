extends Control

signal mouse_inside

@onready var file_diag : FileDialog = $FileDialog
@onready var texture_btn : TextureButton = $VBoxContainer/TextureButton

var last_loc : Vector2
var inside : bool = false
var dragging : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	last_loc = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if check_x() and check_y():
		if not inside and not dragging:
			inside = true
			mouse_inside.emit(inside, name)
	else:
		if inside and not dragging:
			inside = false
			mouse_inside.emit(inside, self.name)
		


func _on_texture_button_pressed() -> void:
	file_diag.visible = true



func _on_file_dialog_file_selected(path: String) -> void:
	print(path)
	var image := Image.load_from_file(path)
	var texture := ImageTexture.create_from_image(image)
	texture_btn.texture_normal = texture


func _on_add_dialogue_pressed() -> void:
	pass # Replace with function body.

func check_x() -> bool:
	return get_global_mouse_position().x > position.x and get_global_mouse_position().x < position.x + size.x

func check_y() -> bool:
	return get_global_mouse_position().y > position.y and get_global_mouse_position().y < position.y + size.y
