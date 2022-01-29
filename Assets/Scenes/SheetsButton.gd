extends TextureButton

var words = ["SYNERGISE", "CALCULATE", "WORK", "FRAUD", "COOK", "COMPLETE", "ADD", "SUBTRACT", "CREATE", "ESTIMATE", "PRODUCE", "WORK", "WORK", "WORK", "WORK"]

onready var button_label = $ButtonTexture/Label
onready var button_audio = $AudioStreamPlayer

var minLoc = Vector2(15, 40)
var maxLoc = Vector2(310, 250)

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_SheetsButton_pressed():
    button_label.text = words[randi()%len(words)]
    rect_position = Vector2(rng.randi_range(minLoc.x, maxLoc.x), rng.randi_range(minLoc.y, maxLoc.y))
    button_audio.play()
