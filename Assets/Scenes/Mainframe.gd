extends Control

signal hack_done

onready var percentage_label = $Label

var percentage = 0
var rng = RandomNumberGenerator.new()

func show():
    .show()
    percentage = 0
    percentage_label.text = "%03d%%" % percentage

func _on_OverloadButton_pressed():
    percentage += rng.randi_range(10, 15)
    percentage_label.text = "%03d%%" % percentage

    if percentage > 100:
        emit_signal("hack_done")
        hide()
