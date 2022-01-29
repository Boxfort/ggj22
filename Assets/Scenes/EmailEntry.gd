extends Panel

signal reply_pressed

onready var subject_label = $Subject
onready var sender_label = $Sender
onready var reply_button = $ReplyButton
onready var button_audio = $AudioStreamPlayer

var subjects = ["Quarterly Report", "What's for lunch???", "Drinks tonight?", "Important Client Meeting", "STOP STEALING FROM THE FRIDGE!!!"]
var senders = ["Jane Doe", "John Doe", "Gaben", "Greg", "Sam", "Jamie", "Duke", "Sophie", "Elizabeth", "HR", "Jimmy", "Lara"]

func _ready():
    subject_label.text = subjects[randi() % len(subjects)]
    sender_label.text = senders[randi() % len(senders)]

func _on_ReplyButton_pressed():
    reply_button.emit_signal("mouse_exited")
    emit_signal("reply_pressed")
    queue_free()
