extends CustomWindow

signal check_player

enum State {
    LOITER,
    CHECK,
    CHECKING
}

var xMin = 10
var xMax = 160
var yMin = 10
var yMax = 160
var center = Vector2(88, 86)

var loiter_pos = Vector2.ZERO
var boss_speed = 5
var desired_location = Vector2.ZERO
var current_state = State.LOITER

onready var boss_tween: Tween = $Content/Tween
onready var boss_dot: Control = $Content/BossDot
onready var distance_label = $Content/DistanceLabel

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    ._ready()
    start_loiter()

func get_random_loiter_pos():
    # Get a random position in the square away from the center
    var rand_x = 0
    var rand_y = 0

    if randi() % 2 == 1:
        rand_x = rng.randi_range(xMin, center.x - 30)
    else:
        rand_x = rng.randi_range(center.x + 30, xMax)

    if randi() % 2 == 1:
        rand_y = rng.randi_range(yMin, center.y - 30)
    else:
        rand_y = rng.randi_range(center.y + 30, yMax)

    print("LOITERING AT: %s" % [str(Vector2(rand_x, rand_y))])
    return Vector2(rand_x, rand_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if current_state == State.LOITER:
        if !boss_dot.rect_position.is_equal_approx(desired_location):
            go_to_desired_location(delta)
        else:
            # Get new position nearby
            desired_location = loiter_pos + Vector2(rng.randi_range(-10, 10), rng.randi_range(-10, 10))
            print("SET NEW")
    elif current_state == State.CHECK:
        if boss_dot.rect_position == desired_location:
            emit_signal("check_player")
            current_state = State.CHECKING
        else:
            go_to_desired_location(delta, boss_speed / 2)

func go_to_desired_location(delta, speed = boss_speed):
    boss_dot.rect_position = boss_dot.rect_position.move_toward(desired_location, speed * delta)
    distance_label.text = "%03dm" % int(boss_dot.rect_position.distance_to(center) / 2)

func start_loiter():
    current_state = State.LOITER
    loiter_pos = get_random_loiter_pos()
    desired_location = loiter_pos

func start_check():
    current_state = State.CHECK
    desired_location = center


func _on_BossButton_pressed():
    show()
