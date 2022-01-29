extends Control

signal corrupt_file_removed

onready var okay_sprite = $Okay
onready var corrupt_sprite = $Corrupt

var corrupt = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func set_corrupted(is_corrupted):
    corrupt = is_corrupted

    if is_corrupted:
        okay_sprite.hide()
        corrupt_sprite.show()
    else:
        okay_sprite.show()
        corrupt_sprite.hide()



func _on_TextureButton_pressed():
    if corrupt:
        emit_signal("corrupt_file_removed")
        hide()