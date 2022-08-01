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
onready var _model: Spatial = $birdLeft
#onready var _birdRBody: KinematicBody = $birdRightKinematicBody

func _physics_process(delta: float) -> void:
#	var min_angle = deg2rad(0.0)
#	var max_angle = deg2rad(90.0)
#	get_node("../birdRightKinematicBody").rotation.y = lerp_angle(min_angle, max_angle, elapsed)
#	elapsed += delta
	
	var move_direction := Vector3.BACK
	move_direction.x = Input.get_action_strength("birdLleft") - Input.get_action_strength("birdLright")
	if (move_direction.x != 0):
		var rot_angle = deg2rad(move_direction.x * rot_speed)
		rotate_y(rot_angle)
		
	"""
	Have rotation happening over time to match keys pressed. Good.
	'Unfinished' if statement no longer interfering with execution of code below. Also good.
		(specifically good to be affecting x axis movement of bird with keys as well as not needing
		to hold down any key to accelerate along z axis--however, we want both other those axes to
		rotate with the bird)
	(Also, I'm unclear on why jumping does nothing in this context, despite currently matching the
		relevant code cannibalized from Thatched, but with the correct action name.)
	Need to calculate ray out from line between birds and limit (clamp) rot_angle in relation to it
	Need to limit length of line between birds' origins to minimum 2*0.875
	(Maximum of wherever they snap back.)
	Then can change birds' collision layers to not interact with each other and stay in control (maybe)
	Want acceleration to be along normal ray rather than axis of world? node? whatever that's not
		changing when the kinematic body rotates (even when buggy things happen with collision, the
		acceleration remains fighting to send us back along the world z axis away from camera)
	After all of that works, we can cause hitting the brakes to subtract acceleration (or just not
		add it while brakes are active, letting the other bird pull ahead more slowly with less
		risk of sudden snap backs and total deceleration)
	For snap back to not be total deceleration...probably need to track the point exactly between
		the birds toward which they'll be snapping, but letting it continue on its vector (without
		acceleration?) still for the half second or whatever it takes for both birds to be back in
		range at 0.875 from center. They should be snapping back faster than the max to take off
		so that shouldn't give us any issues. Theoretically.
	That center point's speed should also be what we're gathering to check for takeoff conditions?
		So we don't fulfill them with the first snapback.
	"""
	_velocity.z += acceleration * delta
	_velocity.x = move_direction.x * speed
#	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.BACK
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("birdjump")
	
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
