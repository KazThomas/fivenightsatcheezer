extends Node

const MOVE_SPEED = 4

var ai_timer

var enemy
var can_move = true
var can_grow = false

func _ready() -> void:
	ai_timer = $"../Timer"
	enemy = $"."

func wait(wait_time): #theoretically should have a timer for each 'animatronic'
	ai_timer.wait_time = wait_time
	ai_timer.start()
	await ai_timer.timeout

func _process(delta: float) -> void:
	attack()

func attack():
	var move_in_from_left = Vector2(enemy.position.x - 500, enemy.position.y)
	if can_move:
		var tween = get_tree().create_tween() #Lerping movement
		tween.tween_property(enemy, "position", move_in_from_left, MOVE_SPEED)
		can_move = false #change to github
		jumpscare()
	#if enemy.position.x >= move_in_from_left.x + 90:
		#$"../GameManager".audio_player.play()

func jumpscare(): #big scare
	var scare = get_tree().create_tween()
	scare.tween_property(enemy, "scale", enemy.scale * 2, MOVE_SPEED)
	can_grow = false
