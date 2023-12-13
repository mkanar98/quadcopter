extends RigidBody

onready var propellor_collision = $PropellorCollision
onready var propellor_visual = $PropellorVisual
onready var chassis_collision = $ChassisCollision
onready var chassis_visual = $ChassisVisual

var propellor_spin_rate = 0 # this is the actual rate the propellor is spinning

var target_velocity = Vector3(0,2,0)
#func move(sx, sy, sz):
#	control = Vector3(sx, sy, sz) 

var speed = Vector3(0,0,0)
	
func _ready():	
	linear_velocity.y = 0
	linear_velocity.x = 0

func _physics_process(delta):
	set_friction(0)


	#linear_velocity.y = control.y 
	#print(control)
	#var current_velocity = linear_velocity                         # this is how fast we are moving in the up direction right now
	#var target_velocity = control                                       # this is how fast we want to be moving
	var delta_velocity = target_velocity - linear_velocity           # this is the change we need in velocity
	
	# now add up lift here based on propellor speed
	var K = 100.0
	var up_force = get_weight() + delta_velocity.y*K
	var side_force = delta_velocity.x*K
	var A = 0.01
	var old_propellor_spin_rate = propellor_spin_rate
	propellor_spin_rate = up_force/A # slowly speed up

	# update visuals
	propellor_visual.rotation_degrees.y += propellor_spin_rate * delta
	#speed += delta_velocity*K*delta
	# calculate torque - when we change our propellor speed there is acounter torque
	var delta_spin_rate = propellor_spin_rate - old_propellor_spin_rate
	var B = 0.2 # this will become some factor - in reality it is based on moment of inertia of propellor
	var torque = -delta_spin_rate * B
	add_torque(Vector3(0,torque,0)) # this makes box move in opposite direction
	
	
	

	add_force(Vector3(side_force,up_force,0), Vector3(0,0,0))
	print(delta, "   ", target_velocity.x-linear_velocity.x, "   ", target_velocity.y -linear_velocity.y,"   ", side_force, "   ", up_force-get_weight(), "   ", speed)
	#if get_linear_velocity() < Vector3(0,1.1,0) and get_linear_velocity() > Vector3(0,9.9,0):
	#if propellor_spin_rate > 1126:
	#	add_force(Vector3(0,-get_weight()-up_force,0), Vector3(0,0,0))
	#elif get_linear_velocity() == Vector3(0,1,0):
	#	add_force(Vector3(0,get_weight(),0), Vector3(0,0,0))
	

	
