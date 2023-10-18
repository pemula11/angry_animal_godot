extends TextureButton

const HOVER_SCALE: Vector2 = Vector2(1.2, 1.2)
const DEFAULT_SCALE: Vector2 = Vector2(1.0, 1.0)

@export var level_number : int = 1
@onready var label = $MC/VB/Label
@onready var score = $MC/VB/Score

var _level_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(level_number)
	score.text = str(ScoreManager.get_best_for_level(level_number))
	_level_scene = load("res://level/level_%s.tscn" % level_number)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	ScoreManager.level_selected(level_number)
	get_tree().change_scene_to_packed(_level_scene)


func _on_mouse_entered():
	scale = HOVER_SCALE


func _on_mouse_exited():
	scale = DEFAULT_SCALE
