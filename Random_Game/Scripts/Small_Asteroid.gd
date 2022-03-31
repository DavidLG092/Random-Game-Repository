extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed
var life
var attack

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "explosion"
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()
	
	life = 10


func _physics_process(delta):
	var collision = move_and_collide(Vector2(speed, 0))
	
	if collision:
		life -= attack
	
	if life <= 0:
		$AnimatedSprite.play()
		$CollisionShape2D.disabled = true
	
	if $AnimatedSprite.frame == 3:
		$AnimatedSprite.stop()
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start():
	show()
	$CollisionShape2D.disabled = false


func set_speed(val):
	speed = val


func set_life(val):
	life = val
	

func set_attack(val):
	attack = val
	

func get_name():
	return "small"
