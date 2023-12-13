
extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var factor = 0.002
var f_up = GlobalRigidBody.f0



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	set_friction(0)
	set_linear_damp(0)
	set_angular_damp(0)

	var force = factor*get_angular_velocity() # y is up
	var offset = Vector3(0,0,0) # for now just apply force to center - but later we can make this work for each propellor position
	add_force(force, offset)
	print(get_angular_velocity())
	
	var current_time = OS.get_ticks_msec()/1000
	if current_time < 10:
		add_torque(Vector3(0,f_up,0))
	#	print(force)
	else:
		add_torque(Vector3(0,0,0))
		
		
	#apply_torque_impulse(Vector3(0,GlobalRigidBody.f0,0))
	#print(get_inverse_inertia_tensor())
	#print(GlobalRigidBody.get_weight())
	#print(OS.get_ticks_msec()/1000)
	#print(delta)
