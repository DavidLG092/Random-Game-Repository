extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Player variables
var speed
var life
var small_attack
var big_attack

# Blast variables

var strength
var blast_time
var blasts_fired
var threshold
var timer_on
var cooldown

# Asteroid varibles

var max_big_runs
var big_runs
var max_small_runs
var small_runs
var big_active
var small_active

var big_life
var small_life
var big_speed
var small_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 150
	life = 10
	big_attack = 10
	small_attack = 5
	
	$Player_Position2D.position = Vector2(100, 300)
	$Player.start($Player_Position2D.position)
	$Player.set_life(life)
	$Player.set_speed(speed)
	$Player.set_attack(big_attack)
	
	strength = 1
	blast_time = 300
	blasts_fired = 0
	threshold = 50
	timer_on = false
	cooldown = false
	
	max_big_runs = 3
	big_runs = 0
	max_small_runs = 7
	small_runs = 0
	big_active = false
	small_active = false
	
	big_life = 10
	small_life = 5
	big_speed = -2
	small_speed = -4
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot"):
		$Blast_Timer.set_one_shot(false)
		$Blast_Timer.set_wait_time(0.1)
		if timer_on == false and cooldown == false:
			$Blast_Timer.start()
			timer_on = true
			
	elif Input.is_action_just_released("shoot"):
		$Blast_Timer.stop()
		
		$Player/AnimatedSprite.stop()
		$Player/AnimatedSprite.frame = 0
		
		timer_on = false
			 
		blasts_fired = 0
		
	if blasts_fired >= threshold:
		$Blast_Timer.stop()
		cooldown = true
		
		$Cooldown_Timer.set_one_shot(true)
		$Cooldown_Timer.set_wait_time(5)
		$Cooldown_Timer.start()
		
	#if big_runs == max_big_runs:
	#	$Blast_Timer.stop()
	#else:
	#	if big_active == false:
	#		$Blast_Timer.start()
	#		big_active = true
		
	$Blasts.text = "Blasts Fired: " + str(threshold - blasts_fired)
	$Cooldown.text = "Cooldown: " + str($Cooldown_Timer.time_left as int)


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
	
	blasts_fired += 1


func _on_Cooldown_Timer_timeout():
	cooldown = false


func _on_Big_Asteroid_Timer_timeout():
	var big_asteroid = preload("res://Scenes/Big_Asteroid.tscn").instance()
	
	big_asteroid.start()
	big_asteroid.scale = Vector2(4, 4)
	
	var spawn_loc = get_node("Asteroids_Path2D/PathFollow2D")
	spawn_loc.offset = randi()
	
	big_asteroid.position = spawn_loc.position
	
	big_asteroid.set_speed(-2)
	big_asteroid.set_life(big_life)
	big_asteroid.set_attack(strength)
	
	add_child(big_asteroid)
	
	big_runs += 1
	$Blasts.text = "asndkajsd"

