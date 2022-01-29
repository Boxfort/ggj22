extends Control

signal hack_done

onready var letter_1 = $Letter
onready var letter_2 = $Letter2
onready var letter_3 = $Letter3
onready var guess_letters = [letter_1, letter_2, letter_3]
onready var word = $Label

var words = ["open", "horse", "battery", "staple", "password", "shoes", "crab", "query", "Gigabyte", "mystery", "buffer"]
var letters = "abcdefghijklmnopqrstuvwxyz"
var current_guess_letter = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    for letter in guess_letters:
        letter.connect("selected", self, "_on_letter_selected")

func get_random_letter():
    return letters[randi() % len(letters)]

func show():
    .show()
    
    var guess_word: String = words[randi() % len(words)]
    var letter_idx = randi()%len(guess_word)
    var letter = guess_word[letter_idx]
    var guess_string = ""
    for idx in len(guess_word):
        if idx == letter_idx:
            guess_string += "_ "
        else:
            guess_string += "%s " % [guess_word[idx]]

    var rand_idx = randi() % 3
    for idx in 3:
        if rand_idx == idx:
            guess_letters[idx].set_letter(letter)
        else:
            guess_letters[idx].set_letter(get_random_letter())

    word.text = guess_string
    current_guess_letter = letter

func _on_letter_selected(letter):
    if letter == current_guess_letter:
        emit_signal("hack_done")
        hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
