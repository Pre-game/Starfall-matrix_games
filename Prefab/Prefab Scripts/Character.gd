extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed : = 7.0
export var jump_strength : = 20.0
export var gravity : = 10.0

var _velocity : = Vector3.ZERO
var _snap_vector : = Vector3.DOWN
 
onready var _spring_arm : SpringArm = $SpringArm
onready var _model : Spatial = $Chararcter

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var move_direction : = Vector3.ZERO
	move_direction.x = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	move_direction.z = Input.get_action_strength("ui_down") -  Input.get_action_strength("ui_up")
#	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y = gravity * delta
	
	var just_landed : = is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping : = is_on_floor() and Input.is_action_just_pressed("ui_jump")
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
	
	if _velocity.length() > 0.2:
		var look_direction = Vector2(_velocity.z, _velocity.x)
		_model.rotation.y = look_direction.angle()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
