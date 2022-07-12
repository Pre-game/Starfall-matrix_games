extends Spatial

var speed = 100

func _physics_process(delta):
	self.global_transform.origin +=  Vector3(0,1,0) * speed * delta
	pass
