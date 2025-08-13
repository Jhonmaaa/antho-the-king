extends CharacterBody2D

@export var speed := 200.0
@export var jump_force := 430.0
@export var gravity := 1400.0
@export var max_fall_speed := 1000.0
@export var acceleration := 2000.0
@export var friction := 1800.0

var jump_buffer_time := 0.12
var coyote_time := 0.10
var jump_buffer := 0.0
var coyote := 0.0
var facing := 1

func _physics_process(delta):
    if not is_on_floor():
        velocity.y = min(velocity.y + gravity * delta, max_fall_speed)
        coyote = max(coyote - delta, 0.0)
    else:
        coyote = coyote_time
        velocity.y = 0.0

    var input_dir := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    if input_dir != 0:
        facing = sign(input_dir)
        velocity.x = move_toward(velocity.x, input_dir * speed, acceleration * delta)
    else:
        velocity.x = move_toward(velocity.x, 0.0, friction * delta)

    if Input.is_action_just_pressed("ui_accept"):
        jump_buffer = jump_buffer_time
    else:
        jump_buffer = max(jump_buffer - delta, 0.0)

    if (jump_buffer > 0.0 and coyote > 0.0):
        velocity.y = -jump_force
        jump_buffer = 0.0
        coyote = 0.0

    if Input.is_action_just_released("ui_accept") and velocity.y < 0:
        velocity.y *= 0.55

    move_and_slide()

    $Sprite2D.flip_h = (facing < 0)
