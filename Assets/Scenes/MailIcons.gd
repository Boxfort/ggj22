extends Control


onready var mail_notification_icon = $Notification
onready var mail_notification_icon_text = $Notification/Label
var email_count = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
    mail_notification_icon.hide()

func _on_EmailWindow_email_replied():
    email_count -= 1
    mail_notification_icon_text.text = str(email_count)
    if email_count == 0:
        mail_notification_icon.hide()

func _on_EmailWindow_email_recieved():
    email_count += 1
    mail_notification_icon_text.text = str(email_count)
    mail_notification_icon.show()
