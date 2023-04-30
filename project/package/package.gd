extends RigidBody2D

## Emitted when this package hits anything
signal hit(body)

const _GLASS_SOUNDS := [
	preload("res://package/glass1.wav"), 
	preload("res://package/glass2.wav"), 
	preload("res://package/glass3.wav"), 
	preload("res://package/glass4.wav")
]

const _HIT_SOUNDS := [
	preload("res://package/kick1.wav"), 
	preload("res://package/kick2.wav"), 
	preload("res://package/kick3.wav"), 
	preload("res://package/kick4.wav")
]

## Used to track if we were hitting something last frame
## so we can determine if this is a new hit.
var _was_hit := false

@onready var _highest_y := global_position.y

func _physics_process(_delta):
	# Track highest y
	_highest_y = min(global_position.y, _highest_y)
	
	# Only worry about new hits
	if get_contact_count() > 0:
		var bodies := get_colliding_bodies()
		
		# There is a bug that comes up if the foot hits the package before
		# it is released, and then there will be no bodies.
		# To catch it, check if there are none.
		if not bodies.is_empty():
			var body := bodies[0]
			if not _was_hit:
				_was_hit = true
				_play_hit_sound()
				hit.emit(body)
	else:
		if _was_hit:
			_was_hit = false


func _play_hit_sound():
	$GlassSound.stream = _GLASS_SOUNDS.pick_random()
	$GlassSound.play()
	$HitSound.stream = _HIT_SOUNDS.pick_random()
	$HitSound.play()


# Get the highest that this package ever reached (the smallest y value)
func get_highest_y()->float:
	return _highest_y
