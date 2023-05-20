extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var pas: AudioStreamPlayer2D = $Pas
@onready var atteri: AudioStreamPlayer2D = $Atteri
@onready var respire_faible: AudioStreamPlayer2D = $RespireFaible
@onready var respire_normale: AudioStreamPlayer2D = $RespireNormale
@onready var respire_forte: AudioStreamPlayer2D = $RespireForte
@onready var slide: AudioStreamPlayer2D = $Slide

@onready var atterissage_particle : PackedScene = preload("res://Level 0/atterissage_particles.tscn")
@onready var pas_particle: PackedScene = preload("res://Level 0/pas_particles.tscn")

const MAX_FALL_SPEED: float = 750  
const GRAVITY: float = 175  
const MAX_JUMP_FORCE: float = -2600
const MIN_JUMP_FORCE: float = -1600
const STEP: float = 0.35

@export var slide_time: float = 0.5
@export var jump_buffer_time_max: float = 0.08
@export var slide_buffer_time_max: float = 0.08

var speed: float = 500
var jump_buffer: float = 0.0
var slide_buffer: float = 0.0
var actual_slide_time: float = 0.0
var is_sliding: bool = false
var step_slide_time: float = 0.05
var step: float = 0.0
var has_landed = false

enum respiration {
	FAIBLE,
	NORMALE,
	FORTE,
}

var respi_interval: float = 30.0
var respi: int = respiration.FAIBLE
var respi_time: float = 0.0

var running_time: float = 0.0
var running_time_interval: float = 10

func _physics_process(delta: float) -> void:
	velocity.x = speed
	if velocity.y >= MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	slide_buffer += delta
	running_time += delta
	respi_time += delta
	
	if not is_on_floor():
		velocity.y += GRAVITY
		jump_buffer += delta
		if velocity.y < 0 and not Input.is_action_pressed("jump") :
			velocity.y = max(velocity.y, MIN_JUMP_FORCE)
		
		if velocity.y > 0:
			animated_sprite_2d.play('FALL')
			
			if Input.is_action_just_pressed('jump'):
				jump_buffer = 0.0
			
			if Input.is_action_just_pressed("slide"):
				slide_buffer = 0.0
		
	else:
		if not has_landed:
			atteri.volume_db = 15
			atteri.play()
			has_landed = true
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				if collision.get_collider().is_in_group("floor"):
					spawn_particles(collision.get_position(), atterissage_particle)
		
		if is_sliding:
			if fmod(actual_slide_time, step_slide_time) == 0.0:
				spawn_particles(position , pas_particle)
			actual_slide_time += delta
			
			if actual_slide_time > slide_time:
				is_sliding = false
				collision_shape_2d.position.y = -15
				collision_shape_2d.scale.y = 1.0
		
		if not is_sliding:
			if running_time > running_time_interval:
				if running_time > running_time_interval * 2.0:
					respi = respiration.FORTE
				else:
					respi = respiration.NORMALE
			
			if velocity.x == 0:
				animated_sprite_2d.play("IDLE")
			else: 
				animated_sprite_2d.play("RUN")
				step += delta
				if step > STEP:
					step = 0.0
					pas.play()
					spawn_particles(position , pas_particle)
				
				if respi_time > respi_interval:
					respi_time = 0.0
					match respi:
						respiration.FAIBLE:
							respire_faible.play()
						respiration.NORMALE:
							respi_interval = 1.25 * respi_interval
							respire_normale.play()
						respiration.FORTE:
							respi_interval = 1.13 * respi_interval
							respire_forte.play()
		
		if Input.is_action_just_pressed('jump') || jump_buffer < jump_buffer_time_max:
			animated_sprite_2d.play("JUMP")
			velocity.y = MAX_JUMP_FORCE
			is_sliding = false
			has_landed = false
			atteri.volume_db = 2.5
			atteri.play()
			spawn_particles(position , pas_particle)
			step = 0.0 
			collision_shape_2d.position.y = -15
			collision_shape_2d.scale.y = 1.0
		
		elif Input.is_action_just_pressed("slide") || slide_buffer < slide_buffer_time_max:
			animated_sprite_2d.play("SLIDE")
			is_sliding = true
			slide.play()
			actual_slide_time = 0.0 
			collision_shape_2d.position.y = -7.5
			collision_shape_2d.scale.y = 0.5
	
	move_and_slide()

func spawn_particles(pos: Vector2, scene: PackedScene):
	var instance = scene.instantiate()
	instance.global_position = pos
	get_tree().get_current_scene().add_child(instance)
