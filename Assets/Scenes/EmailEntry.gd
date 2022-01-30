extends Panel

signal reply_pressed

onready var subject_label = $Subject
onready var sender_label = $Sender
onready var reply_button = $ReplyButton
onready var button_audio = $AudioStreamPlayer

var subjects = ["No gambling in the break room", "Reminder: No fish in the microwaves", "Recent Promotions", "John's anniversary", "Re:Re:Re: so funny!", "Strange Network Traffic", "Welcome our new hires!", "Meeting Invite", "Quarterly Report", "Scheduled Server Maintainence", "Server Room Issues", "The office plants need watering", "NO GAMING (LAST WARNING)", "Network Issues", "Meeting Notes", "All hands meeting today", "Mandatory Team Fun Session", "What's for lunch???", "Drinks tonight?", "Important Client Meeting", "STOP STEALING FROM THE FRIDGE!!!", "Has anyone seen my chair?", "YOU HAVE WON!!1 CLICK HERE NOW", "I QUIT screw you dave"]
var senders = ["Jane", "John", "Gaben", "Greg", "Sam", "Jamie", "Duke", "Sophie", "Elizabeth", "HR", "Jimmy", "Lara", "Gordon", "Alyx", "Barney", "Alex", "Jim", "Daniel", "Sarah", "Ray"]

func _ready():
    subject_label.text = subjects[randi() % len(subjects)]
    sender_label.text = senders[randi() % len(senders)]

func _on_ReplyButton_pressed():
    reply_button.emit_signal("mouse_exited")
    emit_signal("reply_pressed")
    queue_free()
