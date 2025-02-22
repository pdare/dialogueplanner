extends Node2D

@export var zoom_speed : float = 10
@export var zoom_out_max : Vector2 = Vector2(0.107764, 0.107764)
@export var zoom_in_max : Vector2 = Vector2(2.0, 2.0)

@onready var camera : Camera2D = $Camera2D
@onready var panel : Panel = $CanvasLayer/Panel
@onready var menu_bar : MenuBar = $CanvasLayer/MenuBar
@onready var file_btn : PopupMenu = $CanvasLayer/MenuBar/File
@onready var unsaved_exit : Window = $CanvasLayer/ExitUnsavedPopup

# Camera Control vars
var zoom_target : Vector2
var is_dragging : bool = false
var drag_start_mouse_pos : Vector2
var drag_start_cam_pos : Vector2

# Dialogue Node Control vars
var dialogue_btn_array : Array[Control]
var mouse_in_dialogue_node : Array[bool]
var dialogue_button : PackedScene = preload("res://dialogue_node.tscn")
var current_dragging : int
var mouse_position_offset : Vector2

var unsaved_changes = false

func _ready() -> void:
	zoom_target = camera.zoom
	panel.size = menu_bar.size

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_DOWN):
		print(camera.zoom)
	if Input.is_action_just_released("add"):
		var btn = dialogue_button.instantiate()
		btn.custom_minimum_size.x = 50
		btn.custom_minimum_size.y = 50
		add_child(btn)
		btn.position = get_global_mouse_position()
		btn.mouse_inside.connect(_mouse_in_diaglogue_node)
		mouse_in_dialogue_node.append(false)
		dialogue_btn_array.append(btn)
		unsaved_changes = true
	
	if Input.is_action_pressed("drag"):
		var iter = 0
		for md in mouse_in_dialogue_node:
			if md:
				if not dialogue_btn_array[iter].dragging:
					mouse_position_offset = get_global_mouse_position() - dialogue_btn_array[iter].position
					dialogue_btn_array[iter].dragging = true
					dialogue_btn_array[iter].position = lerp(dialogue_btn_array[iter].position - mouse_position_offset, get_global_mouse_position(), 0.5)
					current_dragging = iter
				else:
					#dialogue_btn_array[iter].position = get_global_mouse_position()
					dialogue_btn_array[iter].position = lerp(dialogue_btn_array[iter].position - mouse_position_offset, get_global_mouse_position(), 0.5)
					current_dragging = iter
				break
			iter += 1
	elif Input.is_action_just_released("drag"):
		if dialogue_btn_array.size() > 0:
			dialogue_btn_array[current_dragging].dragging = false
	zoom(delta)
	drag()

func zoom(delta:float) -> void:
	if Input.is_action_just_pressed("zoom_in") and zoom_target * 1.1 <= zoom_in_max:
		zoom_target *= 1.1
	if Input.is_action_just_pressed("zoom_out") and zoom_target * 0.9 >= zoom_out_max:
		zoom_target *= 0.9
	
	camera.zoom = camera.zoom.slerp(zoom_target, zoom_speed * delta)
	
func drag() -> void:
	if !is_dragging and Input.is_action_just_pressed("cam_drag_pan"):
		drag_start_mouse_pos = get_viewport().get_mouse_position()
		drag_start_cam_pos = camera.position
		is_dragging = true
		
	if is_dragging and Input.is_action_just_released("cam_drag_pan"):
		is_dragging = false
		
	if is_dragging:
		var move_vec : Vector2 = get_viewport().get_mouse_position() - drag_start_mouse_pos
		camera.position = camera.position.slerp(drag_start_cam_pos - move_vec * 1/camera.zoom.x, 0.5)


func _mouse_in_diaglogue_node(inside: bool, node_name: StringName) -> void:
	print('mouse in ' + str(inside) + ' ' + node_name)
	var iter = 0
	for dn in dialogue_btn_array:
		if dn.name == node_name:
			mouse_in_dialogue_node[iter] = inside
			break
		iter += 1
		
func save_exit() -> void:
	print('changes saved')
	get_tree().quit()


func _on_file_index_pressed(index: int) -> void:
	if file_btn.get_item_text(index) == "Exit":
		if not unsaved_changes:
			get_tree().quit()
		else:
			unsaved_exit.visible = true
	elif file_btn.get_item_text(index) == "Save":
		unsaved_changes = false


func _on_save_pressed() -> void:
	save_exit()


func _on_exit_pressed() -> void:
	get_tree().quit()
