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
		if(position.y > 903.0):
			set_z_index(3)
		elif(position.y > 500):
			set_z_index(1)
		elif(position.y > 151.0):
			set_z_index(-1)
		else:
			set_z_index(-4)
		
		# Move
		move_and_slide()

func talk(character):
	var textbox = textbox_scene.instantiate()
	textbox.full_name = character
	textbox.set_z_index(10)
	match(character):
		"Alex":
			textbox.text_pages = ["Alex dialogue."]
		"Asa":
			textbox.text_pages = ["Asa dialogue."]
		"David":
			textbox.text_pages = ["David dialogue."]
		"DebugJoe":
			textbox.text_pages = ["Yeah, I'm here too. I don't know.", "Just go with it, I guess.", "&...Okay!", "?Do I know you from somewhere?[Yes; No]"]
		"DebugJoe/Yes":
			textbox.text_pages = ["Oh!", "?I knew it![nahhhh lol i lied; yeah i actually created you]"]
		"DebugJoe/Yes/nahhhh lol i lied":
			textbox.text_pages = ["wth girl why"]
		"DebugJoe/No":
			textbox.text_pages = ["?Are you sure?[idk bro; Yeah definitely]"]
		"DebugJoe/No/yeah i actually created you":
			textbox.text_pages = ["damn"]
		"DebugJoe/idk bro":
			textbox.text_pages = ["fair 'nough"]
		"DebugJoe/Yeah definitely":
			textbox.text_pages = ["ok"]
		"Ivy":
			textbox.text_pages = ["Ivy dialogue."]
		"Jay":
			textbox.text_pages = ["&Hi, Jay!", "?Mreow!![Yeah, it feels...; What?]"]
		"Jay/Yeah, it feels...":
			textbox.text_pages = ["&Yeah, it's... I don't know. Feels strange.", "Mrrreeeww...", "?Myeoow!![I'll be fine; I'm *terrified*]"]
		"Jay/Yeah, it feels.../I'll be fine":
			textbox.text_pages = ["&Thanks, Jay. I think it's going to work out.", "?Mrraoww :3[It's weird; Help the club]"]
		"Jay/Yeah, it feels.../I'll be fine/It's weird":
			textbox.text_pages = ["&It's weird, though, having it all end like this.", "myew myew myuw", "&Yeah... yeah. You're right. I think I needed to hear that.", "&Thank you, Jay.", ":3"]
		"Jay/Yeah, it feels.../I'll be fine/Help the club":
			textbox.text_pages = ["&You'll keep the club in shape when I'm gone, right?", "Myaow!!", "&Yeah. I know you will.", "&It was really nice getting to know you. Keep in touch, 'kay?", "Mmew!"]
		"Jay/Yeah, it feels.../I'm *terrified*":
			textbox.text_pages = ["&Oh, I'm absolutely *terrified.*", "?mrrrrrw[You'll do great; Yeah but... still]"]
		"Jay/Yeah, it feels.../I'm *terrified*/You'll do great":
			textbox.text_pages = ["&No, I know you'll do a great job running the club.", "&It's nice to know it'll outlive me.", "Mrow!!", "&Glad to hear it :)"]
		"Jay/Yeah, it feels.../I'm *terrified*/Yeah but... still":
			textbox.text_pages = ["&I know, but... still.", "&Thanks, though.", "Yeah, no problem!", "&wait what-"]
		"Jay/What?":
			textbox.text_pages = ["?meww :3[I don't understand; Meow!]"]
		"Jay/What?/I don't understand":
			textbox.text_pages = ["&I can't understand you.", "?myaw!![Those aren't words; Teach me]"]
		"Jay/What?/I don't understand/Those aren't words":
			textbox.text_pages = ["&That's not... you're not saying anything.", "&Are you trying to say words?", "mraow myaow myew :3", "All right. Uh... bye."]
		"Jay/What?/I don't understand/Teach me":
			textbox.text_pages = ["Mreow!!", "&Meow?", "mrrrowwww", "&mraoww", "myew!!", "&mraoww!!", "^･ω･^", "∩^⌒ω⌒^∩"]
		"Jay/What?/Meow!":
			textbox.text_pages = ["?mreaw ^･ω･^[myeow :3, Mrreow??]"]
		"Jay/What?/Meow!/myeow :3":
			textbox.text_pages = ["myeww!", "&mrawr"]
		"Jay/What?/Meow!/Mrreow??":
			textbox.text_pages = ["mraoww :3", "&mrr-mrow!", "&mrawoww!!!!"]
		"Jeremie":
			textbox.text_pages = ["Jeremie dialogue."]
		"John":
			textbox.text_pages = ["im john", "&Okay!"]
		"Klaus":
			textbox.text_pages = ["Klaus dialogue."]
		"Ruby":
			textbox.text_pages = ["Ruby dialogue."]
		_:
			textbox.text_pages = ["Oops. This dialogue isn't ever supposed to show up. What happened?", "What did you do???"]
	get_tree().get_root().add_child(textbox)
