extends Control
class_name CustomWindow


onready var exit_button = $ExitButton
onready var drag_handle = $DragHandle

var drag_point = null

func _ready():
    exit_button.connect("pressed", self, "_on_ExitButton_pressed")
    drag_handle.connect("gui_input", self, "on_DragHandle_gui_input")

func _on_DragHandle_gui_input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.pressed:
                # Grab it.
                drag_point = get_global_mouse_position() - get_position()
                print("DRAG")
            else:
                # Release it.
                drag_point = null
                print("LET GO")

    if event is InputEventMouseMotion and drag_point != null:
        print("MOVE")
        set_position(get_global_mouse_position() - drag_point)


func _on_ExitButton_pressed():
    exit_button.emit_signal("mouse_exited")
    hide()


func _on_SheetsButton_pressed():
    show()
