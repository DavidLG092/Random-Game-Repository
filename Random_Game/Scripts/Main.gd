extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Blast variables
var l_blast = preload("res://Scenes/Blast.tscn").instance()
var r_blast = preload("res://Scenes/Blast.tscn").instance()

var strength
var blast_speed
var blasts
var cooldown_time

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Position2D.position = Vector2(100, 300)
	$Player.start($Player_Position2D.position)
	
	l_blast.start()
	l_blast.scale = Vector2(4, 4)
	
	r_blast.start()
	r_blast.scale = Vector2(4, 4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	elif Input.is_action_just_released("shoot"):
		$Player/AnimatedSprite.stop()
		$Player/AnimatedSprite.frame = 0

func shoot():
	$Player/AnimatedSprite.animation = "shooting"
	$Player/AnimatedSprite.speed_scale = blast_speed
	$Player/AnimatedSprite.play()
	
	l_blast.position = Vector2($Player.position.x, $Player.position.y - 25)
	r_blast.position = Vector2($Player.position.x, $Player.position.y + 25)
	
	add_child(l_blast)
	add_child(r_blast)
	
	
