extends Node2D

var room_selection
var is_visible

var audio_interaction
var boop_sound = load("res://Assets/Sounds/boop.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	room_selection = $"../RoomSelection"
	room_selection.propagate_call("set_disabled", [true])
	is_visible = false
	audio_interaction = $"../InteractionAudio"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if !audio_player.is_playing():
		#audio_player.play()
	pass

func _on_camera_button_pressed() -> void:
	if is_visible == false: #make it clickable and visible
		room_selection.propagate_call("set_disabled", [false])
		room_selection.propagate_call("set_visible", [true])
		is_visible = true
	else: #map is invisible
		room_selection.propagate_call("set_disabled", [true])
		room_selection.propagate_call("set_visible", [false])
		is_visible = false

func boop():
	audio_interaction.stream = boop_sound
	audio_interaction.play()
