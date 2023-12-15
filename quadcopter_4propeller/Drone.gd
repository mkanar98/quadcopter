extends RigidBody

var num_propellors = 4

var propellor_collisions = [] # set in ready
var propellor_visuals = [] # set in ready

var old_propellor_spin_rate = [0, 0, 0, 0] # used to track changes
var propellor_spin_rate = [0, 0, 0, 0] # this is the actual rate the propellor is spinning
var propeller_force = [0, 0, 0, 0]

var target_velocity = Vector3(0, 0, 0) # student controls this target velocity through move command
var target_height = Vector3(0,0,0)

var K_P = 10#10.0 
var K_I = 0.5#0.5
var K_D = 5
var integral_control =  0
var integral_control_position =  0
var A = 0.01
var B = 0.2 # this will become some factor - in reality it is based on moment of inertia of propellor
var spin_to_force = 0.001

# student velocity control function
func move(sx, sy, sz):
	target_velocity =  Vector3(sx, sy, sz) 
# student position control function
func lift(sx, sy, sz):
	target_height =  Vector3(sx, sy, sz) 
func _ready():
	angular_damp = 10000.0 # prevent chassis from spinning for now
	linear_velocity.y = 4
	# get propellors
	for i in num_propellors:
		propellor_collisions.append(get_node("PropellorCollision" + str(i+1)))
		propellor_visuals.append(get_node("PropellorVisual" + str(i+1)))
		
	# simulate student calling python command to move up
	move(0,0,0)
	lift(0,5,0)

func update_control(delta):
	#velocity dependent
	#var delta_velocity = target_velocity - linear_velocity # this is the change we need in velocity
	#integral_control += delta_velocity.y*delta
	#var desired_up_force = get_weight() + delta_velocity.y * K + integral_control*K_I
	
	
	#position dependent
	var delta_position = target_height- translation
	integral_control_position += delta_position.y*delta
	var desired_up_force = get_weight() + delta_position.y * K_P + integral_control_position*K_I+K_D*(-linear_velocity.y)
	
	var up_force_per_propellor = desired_up_force/num_propellors
	for i in num_propellors:
		# instantaneous change but one day we will interpolate this
		propellor_spin_rate[i] = up_force_per_propellor/spin_to_force # student controls spin, not force directly
		

func update_propellor_physics(delta):
	for i in num_propellors:
		var propellor_collision = propellor_collisions[i] # visual would be fine to for getting transform
		var origin = propellor_collision.transform.origin # my local offset
		var up_force = (1+0*(2.5-i)/2)*propellor_spin_rate[i] * spin_to_force

	
		# Note this use of origin may not be correct - need to be careful with how Godot uses add_force offset
		add_force(Vector3(0,up_force,0), origin)
		
		# add reverse torques
		var delta_spin_rate = propellor_spin_rate[i] - old_propellor_spin_rate[i]
		var torque = -delta_spin_rate * B
		add_torque(Vector3(0,torque,0)) # this makes box move in opposite direction

		old_propellor_spin_rate[i] = propellor_spin_rate[i]

# called 1x per physics time step
func _physics_process(delta):
	update_control(delta) # student can influence this through move command
	update_propellor_physics(delta) # this is a fixed properry of the system

# called 1x per render - this delta is not fixed - we do cosmetic stuff here - not calculations of any physics
func _process(delta):
	for i in num_propellors:
		propellor_visuals[i].rotation_degrees.y += propellor_spin_rate[i] * delta

	print("Vertical Velocity: ", linear_velocity.y)
	print("Position y: ", translation.y)
	
