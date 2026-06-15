extends CharacterBody2D

signal SELECTED(index)

@export var move_speed : float = 250

var textbox_scene = preload("res://UI/textbox.tscn")

var last_input_direction = Vector2.ZERO
var input_direction = Vector2.ZERO


func _ready():
	Global.player = self


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
	textbox.full_name = character
	match(character):
		"Alex":
			textbox.text_pages = ["Alex dialogue."]
		"Asa":
			textbox.text_pages = ["Asa dialogue."]
		"David":
			textbox.text_pages = ["David dialogue."]
		"DebugJoe":
			textbox.text_pages = ["Yeah, I'm here too. I don't know.", "Just go with it, I guess.", "&...Okay!", "?Do I know you from somewhere?[Yes, No]"]
		"DebugJoe/Yes":
			textbox.text_pages = ["I knew it!"]
		"DebugJoe/No":
			textbox.text_pages = ["Are you sure?"]
		"Ivy":
			textbox.text_pages = ["Ivy dialogue."]
		"Jay":
			textbox.text_pages = ["Jay dialogue."]
		"Jeremie":
			textbox.text_pages = ["Jeremie dialogue."]
		"John":
			textbox.text_pages = ["John dialogue."]
		"Klaus":
			textbox.text_pages = ["Klaus dialogue."]
		"Ruby":
			textbox.text_pages = ["Ruby dialogue."]
		_:
			textbox.text_pages = ["Oops. This dialogue isn't ever supposed to show up. What happened?", "What did you do???"]
	get_tree().get_root().add_child(textbox)
