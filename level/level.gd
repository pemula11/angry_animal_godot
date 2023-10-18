extends Node2D

var animal_scene: PackedScene = preload("res://animal/animal.tscn")

@onready var debug_label = $DebugLabel
@onready var animal_start = $animalStart

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_update_debug_label.connect(on_update_debug_label)
	SignalManager.on_animal_died.connect(on_animal_died)
	setup()
	on_animal_died()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()

func setup():
	var tc = get_tree().get_nodes_in_group(GameManager.GROUP_CUP)
	ScoreManager.set_target_cups(tc.size())

func  on_animal_died():
	var animal = animal_scene.instantiate()
	animal.global_position = animal_start.global_position
	add_child(animal)

func on_update_debug_label(text: String):
	debug_label.text = text
