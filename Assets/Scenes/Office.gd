extends CanvasLayer

onready var startup_audio: AudioStreamPlayer = $StartupNoise
onready var elevator_music = $ElevatorMusic
onready var hacking_music = $HackingMusic
onready var timer = $Timer
onready var manager_text = $ManagerText
onready var click_block = $ClickBlock
onready var meters = $Meters
onready var email_timer = $Windows/EmailWindow/Content/EmailTimer
onready var irc_window = $Windows/IRCWindow

# Called when the node enters the scene tree for the first time.
func _ready():
    click_block.show()
    pause_all()
    startup_audio.connect("finished", self, "_on_startup_noise_finished")
    startup_audio.play()

func pause_all():
    meters.pause_meters()
    email_timer.paused = true

func resume_all():
    meters.resume_meters()
    email_timer.paused = false

func _on_startup_noise_finished():
    # Play the intro
    manager_text.play_intro()
    yield(manager_text, "closed")
    resume_all()
    elevator_music.play()
    click_block.hide()
    timer.wait_time = 44.5
    timer.start()

    # First checkup
    yield(timer, "timeout")
    elevator_music.stop()
    pause_all()
    manager_text.play_first_checkup(meters.productivity_meter.value)
    yield(manager_text, "closed")
    elevator_music.play()
    resume_all()

    # IRC
    timer.wait_time = 30
    yield(timer, "timeout")
    elevator_music.stop()
    pause_all()
    irc_window.play_first_chat()


func _on_HackerIconButton_pressed():
    if !hacking_music.playing:
        hacking_music.play()
    else:
        hacking_music.stream_paused = false
