extends Node2D

@onready var player = $Player
@onready var label = get_node("Camera2D/Label")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var score = player.flytokens
	if score < 5:
		label.text = "SCORE: " + str(score) + "\n" + "METAMORPH: Not Ready"
	else:
		label.text = "SCORE: " + str(score) + "\n" + "METAMORPH: Ready"
