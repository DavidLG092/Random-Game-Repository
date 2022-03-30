extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Functionality variables
var life
var attack

# Movement variables
var speed
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 150
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	velocity *= speed
	
	position += velocity * delta
	position.y = clamp(position.y, 96, screen_size.y - 96)
	
	if life <= 0:
		$AnimatedSprite.animation = "exploding"
		$AnimatedSprite.play()
		$CollisionShape2D.disabled = true
	
	if $AnimatedSprite.frame == 3:
		$AnimatedSprite.stop()
		queue_free()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func set_speed(val):
	speed = val

func set_life(val):
	life = val
	

func set_attack(val):
	attack = val


func _on_Player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	life -= attack
