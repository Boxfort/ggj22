extends Control

signal war_started

onready var productivity_meter: ProgressBar = $Productivity/ProgressBar
onready var war_meter: ProgressBar = $War/ProgressBar
onready var timer = $Tick

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
    timer.connect("timeout", self, "_on_timer_timeout")
    productivity_meter.value = 50
    war_meter.value = 0

func _on_timer_timeout():
    if paused:
        return

    productivity_meter.value = max(productivity_meter.value - 1, 0)
    war_meter.value = war_meter.value + 1

    if war_meter.value == 100:
        emit_signal("war_started")


func _on_SheetsButton_pressed():
    productivity_meter.value = productivity_meter.value + 3


func _on_EmailWindow_email_replied():
    productivity_meter.value = productivity_meter.value + 10

func _on_EmailWindow_emails_waiting(emails):
    if paused:
        return

    productivity_meter.value = productivity_meter.value - emails  

func pause_meters():
    paused = true

func resume_meters():
    paused = false