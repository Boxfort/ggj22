extends CustomWindow


onready var nuke_sound = $Content/NukeButton/AudioStreamPlayer
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()


func _on_NukeButton_pressed():
    if !pressed:
        nuke_sound.play()
        pressed = true


func _on_NukeIconButton_pressed():
    show()
