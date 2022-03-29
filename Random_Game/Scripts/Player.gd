extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Movement variables
var speed
var screen_size

# Player variables
var strength
var blaster_speed
var blasts
var cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 150
	screen_size = get_viewport_rect().size
	
	strength = 10
	blaster_speed = 1
	blasts = 0
	cooldown = 3
	
	$AnimatedSprite.speed_scale = blaster_speed
	$Blast.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("shoot"):
		shoot()
	elif Input.is_action_just_released("shoot"):
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	velocity *= speed
	
	position += velocity * delta
	position.y = clamp(position.y, 96, screen_size.y - 96)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func shoot():
	$AnimatedSprite.animation = "shooting"
	$AnimatedSprite.speed_scale = blaster_speed
	$AnimatedSprite.play()
	
	
