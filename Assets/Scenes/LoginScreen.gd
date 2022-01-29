extends CanvasLayer

func _on_LoginButton_pressed():
    get_tree().change_scene("res://Assets/Scenes/Office.tscn")

func _on_CreditsButton_pressed():
    get_tree().change_scene("res://Assets/Scenes/Credits.tscn")
