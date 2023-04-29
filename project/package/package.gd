extends RigidBody2D

signal hit

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

func _physics_process(_delta):
	# Only worry about new hits
	if get_contact_count() > 0:
		if not _was_hit:
			_was_hit = true
			_play_hit_sound()
			hit.emit()
	else:
		if _was_hit:
			_was_hit = false


func _play_hit_sound():
	$GlassSound.stream = _GLASS_SOUNDS.pick_random()
	$GlassSound.play()
	$HitSound.stream = _HIT_SOUNDS.pick_random()
	$HitSound.play()
