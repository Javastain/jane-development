extends CharacterBody2D

@export var move_speed : float = 250

var textbox_scene = preload("res://UI/textbox.tscn")

var last_input_direction = Vector2.ZERO
var input_direction = Vector2.ZERO

func _physics_process(_delta):
	# Get input direction
	input_direction = Vector2(
		Input.get_action_strength('right') - Input.get_action_strength('left'),
		Input.get_action_strength('down') - Input.get_action_strength('up')
	)
	
	input_direction = input_direction.normalized()
	
	if(Input.is_action_pressed("down") or
	Input.is_action_pressed("up") or
	Input.is_action_pressed("left") or 
	Input.is_action_pressed("right")):
		last_input_direction = input_direction
	
	if(Input.is_action_just_pressed("interact")):
		#talk to npc if they are in front of the player
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, 
		global_position + last_input_direction * 60)
		var result = space_state.intersect_ray(query)
		if(result.size() != 0 and result.collider != null and result.collider.is_in_group("npcs")):
			talk();
	
	# Update velocity
	velocity = input_direction * move_speed
	
	# Move
	move_and_slide()

func talk():
	var textbox = textbox_scene.instantiate()
	textbox.text_pages = ["Hi I'm Jane!"]
	get_tree().get_root().add_child(textbox)
