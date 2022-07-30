extends KinematicBody

"""
Control birdLeft with X for left, C for right, (z for brake)
Control birdRight with M for left, , for right, (. for brake)
Control both with space for jump
Camera follows space between birds (divide bird positions, add offset - if down track, simple)
(Camera rotation pointing down normal of connection between birds or down track?)
"""

export var acceleration := 0.5
export var speed := 7.0
export var rot_speed := 5.0
export var jump_strength := 20.0
export var gravity := 50

var _velocity := Vector3.BACK
var _snap_vector := Vector3.DOWN
var elapsed = 0.0

#onready var _spring_arm: SpringArm = $SpringArm
onready var _model: Spatial = $birdRight
#onready var _birdRBody: KinematicBody = $birdRightKinematicBody

func _physics_process(delta: float) -> void:
#	var min_angle = deg2rad(0.0)
#	var max_angle = deg2rad(90.0)
#	get_node("../birdRightKinematicBody").rotation.y = lerp_angle(min_angle, max_angle, elapsed)
#	elapsed += delta
	
	var move_direction := Vector3.BACK
	move_direction.x = Input.get_action_strength("birdRleft") - Input.get_action_strength("birdRright")
	if (move_direction.x != 0):
		var rot_angle = deg2rad(move_direction.x * rot_speed)
		rotate_y(rot_angle)
#		var rot_y = get_node("../birdRightKinematicBody").rotation.y
#		rot_y += 
	else:
		return
		
	_velocity.z += acceleration * delta
#	_velocity.x = move_direction.x * speed
#	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.BACK
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.BACK
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.BACK, true)

"""
Outfrost rot_y clamping
new_rotation = clamp( old_rotation + rot_angle, min_angle, max_angle )
"""
	

	
	
	# Stolen from Thatched:
#	var move_direction := Vector3.BACK
#	move_direction.x = Input.get_action_strength("birdRleft") - Input.get_action_strength("birdRright") #reversed directions
#
#
#	_velocity.z += acceleration * delta
#
#	_velocity.x = move_direction.x * speed
##	_velocity.z = move_direction.z * speed
#	_velocity.y -= gravity * delta
#
#	var just_landed := is_on_floor() and _snap_vector == Vector3.BACK
#	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
#
#	if is_jumping:
#		_velocity.y = jump_strength
#		_snap_vector = Vector3.BACK
#	elif just_landed:
#		_snap_vector = Vector3.DOWN
#	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.BACK, true)
#
#	if _velocity.length() > 0.2:
#		var look_direction = Vector2(_velocity.z, _velocity.x)
#		_model.rotation.y = look_direction.angle()
#
##func _process(_delta: float) -> void:
##	_spring_arm.translation = translation
