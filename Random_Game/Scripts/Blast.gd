extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	hide()
