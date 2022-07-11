extends SpringArm

export var height = 40.0
export var distance = 20.0



func _ready():
	self.rotate_x(-45.0)
	self.global_transform.origin += Vector3(0.0,height,distance)
