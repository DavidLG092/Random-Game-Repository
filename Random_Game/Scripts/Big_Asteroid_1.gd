extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = "explode"
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()


func _physics_process(delta):
	var collision = move_and_collide(Vector2(-3, 0))
	
	if collision:
		$AnimatedSprite.play()
		if $AnimatedSprite.frame == 4:
			$AnimatedSprite.stop()
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start():
	show()
	$CollisionShape2D.disabled = false
