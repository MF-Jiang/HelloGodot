extends Area2D

var vec_x:float = 1.0

func _ready():
	if vec_x<0:
		self.scale.x=-1

func _physics_process(delta):
	self.position.x+=vec_x
