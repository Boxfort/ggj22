extends CustomWindow

signal email_replied
signal email_recieved
signal emails_waiting

var EmailEntry = load("res://Assets/Scenes/EmailEntry.tscn")

onready var email_timer: Timer = $Content/EmailTimer
onready var email_list = $Content/VBoxContainer
onready var button_audio = $Content/AudioStreamPlayer
onready var email_audio = $Content/EmailRecieved

var max_email_time = 8
var min_email_time = 20

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()

func _on_EmailTimer_timeout():
    var email_entry = EmailEntry.instance()
    email_entry.connect("reply_pressed", self, "_on_email_replied")
    email_list.add_child(email_entry)
    email_timer.wait_time = rng.randi_range(min_email_time, max_email_time)
    emit_signal("email_recieved")
    email_audio.play()

func _on_email_replied():
    button_audio.play()
    emit_signal("email_replied")

func _on_EmailTick_timeout():
    var emails = email_list.get_child_count() - 1
    
    if emails > 0:
        emit_signal("emails_waiting", emails)

func _on_Button_pressed():
    show()