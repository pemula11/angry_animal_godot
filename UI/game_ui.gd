extends CanvasLayer

@onready var level_label = $MC/VB/LevelLabel
@onready var attemps_label = $MC/VB/AttempsLabel
@onready var vb_2 = $MC/VB2
@onready var sound = $Sound


# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "level %s" % ScoreManager.get_level_selected()
	on_attempt_made()
	SignalManager.on_attempt_made.connect(on_attempt_made)
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if vb_2.visible == true and Input.is_key_pressed(KEY_SPACE) == true:
		GameManager.load_main_scene()

func on_attempt_made():
	attemps_label.text = "Attempts %s" % ScoreManager.get_attempts()
	
	
func on_game_over():
	vb_2.show()
	sound.play()
