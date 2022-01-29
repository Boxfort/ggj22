extends Control

signal hack_done

onready var key = $Key

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func show():
    .show()
    key.rect_position = Vector2(281, 93)


func _on_Area2D_body_entered(body:Node):
    if body.get_name() == "Key":
        emit_signal("hack_done")
        key.drag_point = null
        hide()