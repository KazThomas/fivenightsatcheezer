extends Node2D

var room_selection
var is_visible

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room_selection = $"../RoomSelection"
	room_selection.propagate_call("set_disabled", [true])
	is_visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_camera_button_pressed() -> void:
	if is_visible == false:
		room_selection.propagate_call("set_disabled", [false])
		room_selection.propagate_call("set_visible", [true])
		is_visible = true
	else: #map is invisible
		room_selection.propagate_call("set_disabled", [true])
		room_selection.propagate_call("set_visible", [false])
		is_visible = false
