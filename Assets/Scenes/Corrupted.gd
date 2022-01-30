extends Control

signal hack_done

onready var files = $Files

var corrupt_files = 0
var corrupt_files_removed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    for child in files.get_children():
        child.connect("corrupt_file_removed", self, "_on_corrupt_file_removed")

func show():
    .show()
    corrupt_files = 0
    corrupt_files_removed = 0
    while corrupt_files == 0:
        for child in files.get_children():
            child.show()
            if randi()%3 == 1:
                child.set_corrupted(true)
                corrupt_files += 1
            else:
                child.set_corrupted(false)

func _on_corrupt_file_removed():
    corrupt_files_removed += 1
    if corrupt_files_removed >= corrupt_files:
        emit_signal("hack_done")
        hide()
