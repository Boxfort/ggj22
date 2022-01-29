extends Panel

signal closed
signal fired

var intro_text = "I want to see lots of good work today! I'll be back to check on you every so often to make sure you're being !PRODUCTIVE! and you're not doing anything you shouldn't be. No more antics, especially after last time.\n\nHave a productive day!"
var first_checkup_good = "I'm back! \nWow very impressive, keep this up and you might just get those unpaid holiday days I took from you! \nKeep it up!"
var first_checkup_okay = "I'm back! \nHmmmm, your productivity could use some work. I want to see some improvement the next time I come back."
var first_checkup_bad = "I'm back! \nWhat have you been doing??? You better not be slacking off when I'm not around. I want to see some SERIOUS improvement.\n OR ELSE!"

var check_good = ["Wow fantastic job! Keep working hard."]
var check_okay = ["Hello! \n\n You're doing... fine. Try and pick up the pace a little bit huh? I'll be back later."]
var check_bad = ["Well well well... slacking on the job once again. I'm not going to put up with this much more. \n\nYou've got one more chance."]

var fired_bad = "Slacking AGAIN?!?!? \n\n This is totally unacceptable, you're fired!"
var fired_naughty = "What the hell is all this? This isn't work. I'm going to have to fire you for so blatantly slacking. Effective immediately."

var first_time_bad = true
var fired = false

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

func check(productivity, naughty_windows_open):
    if naughty_windows_open:
        text.text = fired_naughty
        fired = true
    else:
        if productivity > 75:
            text.text = check_good[randi()% len(check_good)]
        elif productivity > 40:
            text.text = check_okay[randi()% len(check_okay)]
        else:
            if first_time_bad:
                text.text = check_bad[randi()% len(check_bad)]
            else:
                text.text = fired_bad
                fired = true
    text.visible_characters = 0
    show()
    var delay = get_tree().create_timer(1)
    yield(delay, "timeout")
    timer.start()
    audio.play()

func _on_Timer_timeout():
    text.visible_characters += 1
    if text.visible_characters >= len(text.text) - 5:
        timer.stop()
        audio.stop()
        var delay = get_tree().create_timer(0.5)
        yield(delay, "timeout")
        okay_button.show()

func _on_okay_pressed():
    emit_signal("closed", fired)
    okay_button.emit_signal("mouse_exited")
    hide()
