extends TextureButton


func _on_ExitButton_pressed():
    print("load")
    get_tree().change_scene("res://Assets/Scenes/LoginScreen.tscn")