extends NinePatchRect


onready var time_label = $Time

func _process(delta):
    var date_time = OS.get_time()
    time_label.text = "%02d:%02d" % [int(date_time["hour"]), int(date_time["minute"])]
