extends Node2D

signal left_mouse_clicked
signal left_mouse_released


const COLLISION_MASK_ROOM = 1

var inputs_disabled = false
var background_img

var replacement_img = str("res://Assets/Art/scorsepeup.jpg")
var original_img = str("res://Assets/Art/frpgguy2.jpg")

var has_changed = true
func _ready() -> void:
	background_img = $"../Background".get_node("Sprite2D")
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("left_mouse_clicked")
			raycast_at_cursor()

func raycast_at_cursor():
	if inputs_disabled:
		return
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		var result_col_mask = result[0].collider.collision_mask
		if result_col_mask == COLLISION_MASK_ROOM:
			var result_name = result[0].collider.name
			if result_name != "Exit":
				#change the background to the new room
				change_room(result_name)
			else:
				#exit the room selection thing (back to full office)
				$"../GameManager"._on_camera_button_pressed()

func change_room(roomname):
	
	if has_changed == true:
		background_img.texture = load(replacement_img)
		has_changed = false
	else:
		background_img.texture = load(original_img)
		has_changed = true
	match roomname:
		"KazRoom":
			print("In KazRoom")
		"MovieRoom":
			print("In Movie")
		"ThirdSpace":
			print("In Third Space")
		"TheGrater":
			print("In Da Grater Baby")
		"IKB":
			print("Having a pint")
		"Deco":
			print("Having an Odin's BrU")
		"Palmy":
			print("Having Pizza")
		"Kitchen":
			print("Having a worse Pizza")
