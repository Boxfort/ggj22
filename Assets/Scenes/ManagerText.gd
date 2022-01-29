extends Panel

signal closed

var intro_text = "I want to see lots of good work today! I'll be back to check on you every so often to make sure you're being !PRODUCTIVE! and you're not doing anything you shouldn't be. No more antics, especially after last time.\n\nHave a productive day!"
var first_checkup_good = "I'm back! \nWow very impressive, keep this up and you might just get those unpaid holiday days I took from you! \nKeep it up!"
var first_checkup_okay = "I'm back! \nHmmmm, your productivity could use some work. I want to see some improvement the next time I come back."
var first_checkup_bad = "I'm back! \nWhat have you been doing??? You better not be slacking off when I'm not around. I want to see some SERIOUS improvement.\n OR ELSE!"

onready var text = $Text
onready var timer = $Timer
onready var audio: AudioStreamPlayer = $AudioStreamPlayer
onready var okay_button = $OkayButton

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    okay_button.connect("pressed", self, "_on_okay_pressed")

func show():
    .show()
    okay_button.hide()

func play_intro():
    text.text = intro_text
    text.visible_characters = 0
    show()
    var delay = get_tree().create_timer(1)
    yield(delay, "timeout")
    timer.start()
    audio.play()
    show()

func play_first_checkup(productivity):
    if productivity > 75:
        text.text = first_checkup_good
    elif productivity > 40:
        text.text = first_checkup_okay
    else:
        text.text = first_checkup_bad
    text.visible_characters = 0
    show()
    var delay = get_tree().create_timer(1)
    yield(delay, "timeout")
    timer.start()
    audio.play()
    show()


func _on_Timer_timeout():
    text.visible_characters += 1
    if text.visible_characters >= len(text.text) - 5:
        timer.stop()
        audio.stop()
        var delay = get_tree().create_timer(0.5)
        yield(delay, "timeout")
        okay_button.show()

func _on_okay_pressed():
    emit_signal("closed")
    okay_button.emit_signal("mouse_exited")
    hide()
