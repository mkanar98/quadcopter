extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var f0 = 5


#func set_angular_velocity(new_angular_velocity):
#	target_propellor_angular_velocity = new_angular_velocity

#var ang_v = set_angular_velocity(Vector3(0,f0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	set_friction(0)
	set_linear_damp(0)
	set_angular_damp(0)
	#var force = Vector3(0,f0,0) # y is up
	#var offset = Vector3(0,0,0) # for now just apply force to center - but later we can make this work for each propellor position
	
	#add_force(force, offset)
	#apply_torque_impulse(Vector3(0,-f0,0))
	#add_torque(Vector3(0,f0,0))
	#set_angular_velocity(Vector3(0,-f0,0))
	#print(get_inverse_inertia_tensor())
	
