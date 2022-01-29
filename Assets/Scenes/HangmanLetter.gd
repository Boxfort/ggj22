extends TextureButton


signal selected

onready var letter = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func set_letter(new_letter):
    letter.text = new_letter

func _on_Letter_pressed():
    emit_signal("selected", letter.text)