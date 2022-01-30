extends Control

signal hack_done

onready var sql_label:Label = $Label
onready var inject_button = $InjectButton
onready var create_button = $CreateButton

var percent_shown = 0

func show():
    .show()
    inject_button.hide()
    percent_shown = 0
    sql_label.percent_visible = 0


func _on_CreateButton_pressed():
    if percent_shown >= 1:
        return
    percent_shown = min(percent_shown + 0.2, 1)
    sql_label.percent_visible = percent_shown
    if percent_shown >= 1:
        inject_button.show()

func _on_InjectButton_pressed():
    inject_button.emit_signal("mouse_exited")
    emit_signal("hack_done")
    hide()
