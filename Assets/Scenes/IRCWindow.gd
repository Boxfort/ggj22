extends CustomWindow

signal show_boss_tracker
signal boss_tracker_opened
signal show_hacker_term
signal typing_done
signal closed

onready var messages = $Content/VBoxContainer
onready var message_audio = $Content/MessageAudio
onready var send_button = $Content/SendButton
onready var timer = $Content/Timer
onready var input_text = $Content/Input/LineEdit

var ChatMessage = load("res://Assets/Scenes/IRCMessage.tscn")
var first_chat_a = ["z0mg the planet is going to explode", "u gotta help!", "1337(R3w are trying to remotely hack the worlds nukes"]
var first_chat_a_response = "dude im at work"
var first_chat_b = ["if you don't help the world will end!"]
var first_chat_b_response = "if i get fired again it might as well end"
var first_chat_c = ["don't be a dick", "look, i've sent you a program", "you can use it to track your boss and not get caught", "try it out now"]
var first_chat_d = ["pretty cool huh?", "so will you help?!"]
var first_chat_d_response = "okay fine..."
var first_chat_e = ["okay great", "I've sent you the program to intercept the hackers", "good luck"]

var visible_chars = 0
var current_txt = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()
    timer.connect("timeout", self, "_on_Timer_timeout")

func add_friend_message(txt):
    message_audio.play()
    var chat_message = ChatMessage.instance()
    chat_message.text = "|3o#F0rT - %s" % [txt]
    messages.add_child(chat_message)

func add_player_message(txt):
    input_text.text = ""
    var chat_message = ChatMessage.instance()
    chat_message.text = "0ff1c3_B01 - %s" % [txt]
    messages.add_child(chat_message)

func play_first_chat():
    show()
    var delay = get_tree().create_timer(0.5)
    yield(delay, "timeout")

    for msg in first_chat_a:
        add_friend_message(msg)
        delay = get_tree().create_timer(2.0)
        yield(delay, "timeout")

    start_player_typing(first_chat_a_response)
    yield(self, "typing_done")
    yield(send_button, "pressed")
    add_player_message(current_txt)

    delay = get_tree().create_timer(3.0)
    yield(delay, "timeout")

    for msg in first_chat_b:
        add_friend_message(msg)
        delay = get_tree().create_timer(3)
        yield(delay, "timeout")

    start_player_typing(first_chat_b_response)
    yield(self, "typing_done")
    yield(send_button, "pressed")
    add_player_message(current_txt)

    delay = get_tree().create_timer(3.0)
    yield(delay, "timeout")

    for msg in first_chat_c:
        add_friend_message(msg)
        delay = get_tree().create_timer(2)
        yield(delay, "timeout")
    
    emit_signal("show_boss_tracker")
    yield(self, "boss_tracker_opened")

    for msg in first_chat_d:
        add_friend_message(msg)
        delay = get_tree().create_timer(2)
        yield(delay, "timeout")

    start_player_typing(first_chat_d_response)
    yield(self, "typing_done")
    yield(send_button, "pressed")
    add_player_message(current_txt)

    delay = get_tree().create_timer(3.0)
    yield(delay, "timeout")

    for msg in first_chat_e:
        add_friend_message(msg)
        delay = get_tree().create_timer(2)
        yield(delay, "timeout")

    emit_signal("show_hacker_term")
    delay = get_tree().create_timer(2)
    yield(delay, "timeout")
    emit_signal("closed")
    hide()


func start_player_typing(msg):
    visible_chars = 0
    current_txt = msg
    timer.start()

func _on_Timer_timeout():
    visible_chars += 1
    input_text.text = current_txt.substr(0, visible_chars)
    if visible_chars >= len(current_txt):
        timer.stop()
        emit_signal("typing_done")

func _on_BossButton_pressed():
    emit_signal("boss_tracker_opened")
