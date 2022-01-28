extends Node2D

onready var cursor_hand = $CursorHand
onready var cursor_arrow = $CursorArrow

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    var children = get_tree().get_nodes_in_group("buttons")
    for child in children:
        child.connect("mouse_entered", self, "_on_mouse_enter_button")
        child.connect("mouse_exited", self, "_on_mouse_exit_button")

func _on_mouse_enter_button():
    cursor_hand.show()
    cursor_arrow.hide()

func _on_mouse_exit_button():
    cursor_hand.hide()
    cursor_arrow.show()

func _process(_delta):
    # Make this node follow the mouse position
    var mouse_position = get_global_mouse_position()
    position = mouse_position
