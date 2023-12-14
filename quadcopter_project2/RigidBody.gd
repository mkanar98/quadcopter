extends RigidBody

var Drone1 = Drone.new()
var Drone2 = Drone.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Drone1.move(0,1,0)
	Drone2.move(0,2,0)
	set_linear_velocity(Vector3(0,1,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Drone1.move(0,1,0)
	Drone2.move(0,2,0)
	#set_linear_velocity(Drone1.linear_velocity+Drone2.linear_velocity)
	add_force(Vector3(0,get_weight(),0),Vector3(0,0,0))
#	pass
	print(Drone1.linear_velocity, linear_velocity, get_weight())
