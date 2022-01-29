extends CustomWindow

signal hack_complete

onready var hacks = $Content/Hacks
onready var hack_complete_audio = $Content/HackComplete

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()
    for child in hacks.get_children():
        child.connect("hack_done", self, "_on_hack_complete")
    show_random_hack()

func show_random_hack():
    var delay = get_tree().create_timer(0.25)
    yield(delay, "timeout")
    hacks.get_children()[randi()%hacks.get_child_count()].show()

func _on_hack_complete():
    hack_complete_audio.play()
    show_random_hack()
    emit_signal("hack_complete")

func _on_ExitButton_pressed():
    hide()

func _on_HackerIconButton_pressed():
    show()