extends Control

var dialogue_btn_array : Array[Control]
var mouse_in_dialogue_node : Array[bool]
var dialogue_button : PackedScene = preload("res://dialogue_node.tscn")
var current_dragging : int
var mouse_position_offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("add"):
		var btn = dialogue_button.instantiate()
		btn.custom_minimum_size.x = 50
		btn.custom_minimum_size.y = 50
		add_child(btn)
		btn.position = get_global_mouse_position()
		btn.mouse_inside.connect(_mouse_in_diaglogue_node)
		mouse_in_dialogue_node.append(false)
		dialogue_btn_array.append(btn)
	
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

func _mouse_in_diaglogue_node(inside: bool, node_name: StringName) -> void:
	print('mouse in ' + str(inside) + ' ' + node_name)
	var iter = 0
	for dn in dialogue_btn_array:
		if dn.name == node_name:
			mouse_in_dialogue_node[iter] = inside
			break
		iter += 1
