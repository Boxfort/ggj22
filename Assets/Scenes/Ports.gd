extends Control

signal hack_done

onready var ports_node = $Ports

# 1 - 1023
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    for child in ports_node.get_children():
        child.connect("pressed", self, "_on_port_pressed")

func show():
    var checked = 0
    .show()
    while checked == 0:
        for child in ports_node.get_children():
            child.text = str(rng.randi_range(1, 1023))
            if randi() % 3 == 1:
                child.pressed = true
                checked += 1
            else:
                child.pressed = false

func _on_port_pressed():
    for child in ports_node.get_children():
        if child.pressed:
            return
    emit_signal("hack_done")
    hide()
