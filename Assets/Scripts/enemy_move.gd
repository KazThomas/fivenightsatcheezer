extends Node

const MOVE_SPEED = 2
const GROW_SPEED = 0.6
const GROWTH_MODIFIER = 3.4

var ai_timer

var enemy
var can_move = true
var can_grow = false

var audio_enemy
var stone_sound = load("res://Assets/Sounds/moving-stone.mp3")
var jumpscare_sound = load("res://Assets/Sounds/jumpscare.mp3")

func _ready() -> void:
	ai_timer = $"../Timer"
	enemy = $"."
	audio_enemy = $"../EnemyAudio"
	audio_enemy.stream = stone_sound
	attack()

func wait(wait_time): #theoretically should have a timer for each 'animatronic'
	ai_timer.wait_time = wait_time
	ai_timer.start()
	await ai_timer.timeout

func _process(delta: float) -> void:
	pass
	#attack()

func attack():
	var move_in_from_left = Vector2(enemy.position.x - 500, enemy.position.y)
	audio_enemy.play()
	if can_move:
		var tween = get_tree().create_tween() #Lerping movement
		tween.tween_property(enemy, "position", move_in_from_left, MOVE_SPEED)
		can_move = false #change to github
		await wait(3)
		jumpscare()

func jumpscare(): #big scare
	audio_enemy.stream = jumpscare_sound
	var scare = get_tree().create_tween()
	scare.tween_property(enemy, "scale", enemy.scale * GROWTH_MODIFIER, GROW_SPEED)
	audio_enemy.play()
	can_grow = false
