extends CharacterBody2D

signal SELECTED(index)

@export var move_speed : float = 250

var textbox_scene = preload("res://UI/textbox.tscn")

var last_input_direction = Vector2.ZERO
var input_direction = Vector2.ZERO

func _physics_process(_delta):
	
	if not Global.in_dialouge:
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
			global_position + (last_input_direction * 90))
			var result = space_state.intersect_ray(query)
			if(result.size() != 0 and result.collider != null and result.collider.is_in_group("npcs")):
				talk(result.collider.name);
		
		# Update velocity
		velocity = input_direction * move_speed
		
		# Layering
		if(position.y > 500):
			set_z_index(1)
		else:
			set_z_index(-1)
		
		# Move
		move_and_slide()

func talk(character):
	var textbox = textbox_scene.instantiate()
	textbox.character = character
	if(character == "Alex"):
		textbox.text_pages = ["Alex dialogue."]
	elif(character == "Asa"):
		textbox.text_pages = ["Asa dialogue."]
	elif(character == "David"):
		textbox.text_pages = ["David dialogue."]
	elif(character == "DebugJoe"):
		textbox.text_pages = ["Yeah, I'm here too. I don't know.", "Just go with it, I guess.", "&...Okay!"]
	elif(character == "Ivy"):
		textbox.text_pages = ["Ivy dialogue."]
	elif(character == "Jay"):
		textbox.text_pages = ["Jay dialogue."]
	elif(character == "Jeremie"):
		textbox.text_pages = ["Jeremie dialogue."]
	elif(character == "John"):
		textbox.text_pages = ["John dialogue."]
	elif(character == "Klaus"):
		textbox.text_pages = ["Klaus dialogue."]
	elif(character == "Ruby"):
		textbox.text_pages = ["Ruby dialogue."]
	else:
		textbox.text_pages = ["Oops. This dialogue isn't ever supposed to show up. What happened?", "What did you do???"]
	get_tree().get_root().add_child(textbox)
