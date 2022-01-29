extends CanvasLayer

signal nuke_pressed

onready var windows = $Windows
onready var gameover_color = $GameOverColor
onready var gameover_sound = $GameOverSound
onready var gameover_window = $GameOverWindow
onready var startup_audio: AudioStreamPlayer = $StartupNoise
onready var elevator_music = $ElevatorMusic
onready var hacking_music = $HackingMusic
onready var timer = $Timer
onready var boss_timer = $BossTimer
onready var manager_text = $ManagerText
onready var click_block = $ClickBlock
onready var meters = $Meters
onready var email_timer = $Windows/EmailWindow/Content/EmailTimer
onready var irc_window = $Windows/IRCWindow
onready var boss_window = $Windows/BossLocatorWindow
onready var hack_window = $Windows/HackingWindow
onready var you_window = $YouWindow
onready var nuke_window = $Windows/CyberNukeWindow

onready var boss_icon = $Icons/BossLocatorIcon
onready var hacker_icon = $Icons/HackerIcon
onready var nuke_icon = $Icons/NukeIcon

var rng = RandomNumberGenerator.new()
var min_boss_time = 35
var max_boss_time = 55

# Called when the node enters the scene tree for the first time.
func _ready():
    click_block.show()
    pause_all()
    startup_audio.connect("finished", self, "_on_startup_noise_finished")
    startup_audio.play()

func pause_all():
    meters.pause_meters()
    email_timer.paused = true
    boss_timer.paused = true

func resume_all():
    meters.resume_meters()
    email_timer.paused = false
    boss_timer.paused = false

func _on_startup_noise_finished():
    # Play the intro
    manager_text.play_intro()
    yield(manager_text, "closed")
    resume_all()
    elevator_music.play()
    click_block.hide()
    timer.wait_time = 5#44.5
    timer.start()

    # First checkup
    yield(timer, "timeout")
    click_block.show()
    elevator_music.stop()
    pause_all()
    manager_text.play_first_checkup(meters.productivity_meter.value)
    yield(manager_text, "closed")
    elevator_music.play()
    click_block.hide()
    resume_all()

    # IRC1
    timer.wait_time = 5#30
    timer.start()
    yield(timer, "timeout")
    elevator_music.stop()
    pause_all()
    irc_window.play_first_chat()
    yield(irc_window, "closed")
    resume_all()
    boss_timer.start() # boss starts showing up randomly

    # Fix up music
    elevator_music.play()
    if hacking_music.playing:
        elevator_music.stream_paused = true

    # IRC2 (timer started when opening hack menu)
    yield(timer, "timeout")
    pause_music()
    pause_all()
    irc_window.play_second_chat()
    yield(irc_window, "closed")
    resume_all()
    resume_music()

    # IRC3
    timer.wait_time = 60
    timer.start()
    yield(timer, "timeout")
    pause_music()
    pause_all()
    irc_window.play_third_chat()
    yield(irc_window, "closed")

    # Once we're on the nuke stage no more managers
    boss_timer.stop()
    hack_window.hide()

    # Wait for the player to nuke
    yield(self, "nuke_pressed")
    
    timer.wait_time = 3
    timer.start()
    yield(timer, "timeout")
    irc_window.play_fourth_chat()
    yield(irc_window, "closed")

    meters.disable_war()
    hack_window.hide()
    boss_window.hide()
    nuke_window.hide()
    boss_icon.hide()
    hacker_icon.hide()
    nuke_icon.hide()
    resume_all()

    # Final Manager Chat
    timer.wait_time = 15
    timer.start()
    yield(timer, "timeout")
    click_block.show()
    pause_music()
    pause_all()
    manager_text.play_last_checkup()
    yield(manager_text, "closed")

    you_window.show()


var first_open = true

func _on_HackerIconButton_pressed():
    if first_open:
        timer.wait_time = 150
        timer.start()
        meters.enable_war()
        first_open = false

    if !hacking_music.playing:
        hacking_music.play()
        elevator_music.stream_paused = true
    else:
        if hacking_music.stream_paused:
            elevator_music.stream_paused = true
            hacking_music.stream_paused = false
            

func _on_ExitButton_pressed():
    hacking_music.stream_paused = true
    elevator_music.stream_paused = false


func pause_music():
    elevator_music.stream_paused = true
    hacking_music.stream_paused = true

func resume_music():
    if are_naughty_windows_open():
        hacking_music.stream_paused = false
    else:
        elevator_music.stream_paused = false


func are_naughty_windows_open():
    return (boss_window.visible || hack_window.visible)

func do_boss_check():
    # Wait for boss to reach player
    yield(boss_window, "check_player")
    # Play the check
    pause_all()
    pause_music()
    click_block.show()
    manager_text.check(meters.productivity_meter.value, are_naughty_windows_open())
    var fired = yield(manager_text, "closed")
    if fired:
        # TODO: gameover screen
        get_tree().change_scene("res://Assets/Scenes/LoginScreen.tscn")
        pass
    resume_all()
    resume_music()
    click_block.hide()
    boss_window.start_loiter()
    boss_timer.start()
    # Continue the main timer
    timer.paused = false


func _on_BossTimer_timeout():
    # Make sure we don't trigger any story events while the boss is coming
    timer.paused = true 
    boss_window.start_check()
    do_boss_check()
    boss_timer.wait_time = rng.randi_range(min_boss_time, max_boss_time)


func _on_NukeButton_pressed():
    emit_signal("nuke_pressed")


func _on_Meters_war_started():
    click_block.show()
    windows.hide()
    pause_all()
    pause_music()
    gameover_window.show()
    var delay = get_tree().create_timer(2)
    yield(delay, "timeout")
    gameover_color.show()
    gameover_sound.play()
    delay = get_tree().create_timer(5)
    yield(delay, "timeout")
    get_tree().change_scene("res://Assets/Scenes/LoginScreen.tscn")
