extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var f0 = 10
var propellor_angular_velocity = 0 # current
var target_propellor_angular_velocity = f0 # target
var angular_velocity_interpolation_rate = 1.0 # how fast we change to target

#func set_angular_velocity(new_angular_velocity):
#	target_propellor_angular_velocity = new_angular_velocity

#var ang_v = set_angular_velocity(Vector3(0,f0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	var force = Vector3(0,f0,0) # y is up
	var offset = Vector3(0,0,0) # for now just apply force to center - but later we can make this work for each propellor position
	add_force(force, offset)
	set_angular_velocity(Vector3(0,f0,0))




