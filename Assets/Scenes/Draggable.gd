extends TextureRect

var drag_point = null

func _ready():
    self.connect("gui_input", self, "_on_gui_input")

func _on_gui_input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            if event.pressed:
                # Grab it.
                drag_point = get_global_mouse_position() - get_position()
            else:
                # Release it.
                drag_point = null

    if event is InputEventMouseMotion and drag_point != null:
        set_position(get_global_mouse_position() - drag_point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
