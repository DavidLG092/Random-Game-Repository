extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Blast variables

var strength
var blast_time
var blasts_fired
var threshold
var timer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player_Position2D.position = Vector2(100, 300)
	$Player.start($Player_Position2D.position)
	
	strength = 10
	blast_time = 300
	blasts_fired = 0
	threshold = 50
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot"):
		$Blast_Timer.set_one_shot(false)
		$Blast_Timer.set_wait_time(0.1)
		if timer == false:
			$Blast_Timer.start()
			timer = true
	elif Input.is_action_just_released("shoot"):
		$Blast_Timer.stop()
		$Player/AnimatedSprite.stop()
		$Player/AnimatedSprite.frame = 0
		$Label.text = "hey there"

func _on_Blast_Timer_timeout():
	var l_blast = preload("res://Scenes/Blast.tscn").instance()
	var r_blast = preload("res://Scenes/Blast.tscn").instance()
	
	l_blast.start()
	l_blast.scale = Vector2(4, 4)
	
	r_blast.start()
	r_blast.scale = Vector2(4, 4)
	
	$Player/AnimatedSprite.animation = "shooting"
	$Player/AnimatedSprite.speed_scale = blast_time/100
	$Player/AnimatedSprite.play()
	
	l_blast.position = Vector2($Player.position.x + 12, $Player.position.y - 28)
	r_blast.position = Vector2($Player.position.x + 12, $Player.position.y + 28)
	
	l_blast.set_speed(blast_time)
	r_blast.set_speed(blast_time)
	
	add_child(l_blast)
	add_child(r_blast)
	
	$Label.text = "hello there"
	
	timer = false
	blasts_fired += 1
