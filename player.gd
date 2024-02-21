extends CharacterBody2D

var speed = 4000

var animationPlayer : AnimatedSprite2D
var time_to_play_animation = 66

func _ready():
	animationPlayer = $AnimatedSprite2D

func _physics_process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized() * delta * speed
	move_and_slide()
	if velocity.x < 0:
		play_animation_with_duration("walk_left", velocity.length())
	elif velocity.x > 0:
		play_animation_with_duration("walk_right", velocity.length())
	elif velocity.y < 0:
		play_animation_with_duration("walk_up", velocity.length())
	elif velocity.y > 0:
		play_animation_with_duration("walk_down", velocity.length())
		
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("Body"):
			collision.get_collider().apply_central_impulse(-collision.get_normal())

func play_animation_with_duration(animation_name, duration):
	animationPlayer.play(animation_name)
	animationPlayer.speed_scale = 2
