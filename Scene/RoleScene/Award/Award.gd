extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var direct :Vector2 = Vector2.RIGHT
var attack :bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# set_process(true)
	$AnimatedSprite2D.play("Walk")

func _physics_process(delta):
	
	if !is_instance_valid($RightDownCast.get_collider()):
		direct = Vector2.LEFT
		$AnimatedSprite2D.flip_h = true
	elif !is_instance_valid($LeftDownCast.get_collider()):
		direct = Vector2.RIGHT
		$AnimatedSprite2D.flip_h = false
	

	if direct == Vector2.RIGHT && is_instance_valid($RightAttackCheck.get_collider()) && attack == false:
		attack = true
		$AnimatedSprite2D.play("Attack")
		$AnimatedSprite2D.flip_h = false
		return
	elif direct == Vector2.LEFT && is_instance_valid($LeftAttackCheck.get_collider()) && attack == false:
		attack = true
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Attack")
		return
		
	if attack == true:
		return	
	self.velocity = direct * SPEED
	self.velocity.y = gravity
	move_and_slide()


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation=="Attack":
		if $AnimatedSprite2D.frame == 8:
			var sce = preload("res://Scene/RoleScene/Award/Attack/Attack.tscn").instantiate()
			if direct == Vector2.RIGHT:
				sce.position = $Rshoot.global_position
			else:
				sce.position = $Lshoot.global_position
			sce.vec_x = direct.x
			get_parent().add_child(sce)
				



func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Attack":
		attack =false
		$AnimatedSprite2D.play("Walk")
