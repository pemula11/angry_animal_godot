extends StaticBody2D

@onready var animation_player = $AnimationPlayer
@onready var vanish_sound = $vanishSound


func die():
	vanish_sound.play()
	animation_player.play("vanish")

func _on_vanish_sound_finished():
	SignalManager.on_cup_destroy.emit()
	queue_free()
