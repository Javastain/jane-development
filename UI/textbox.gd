extends Node2D

var text_pages = []
var initialized = false
var page = 0
var full_name = ""
var character = ""
var can_move_on = true
var choices = []

var alex_portrait = preload("res://Art/debug_joe_portrait.png")
var asa_portrait = preload("res://Art/debug_joe_portrait.png")
var david_portrait = preload("res://Art/debug_joe_portrait.png")
var debug_joe_portrait = preload("res://Art/debug_joe_portrait.png")
var ivy_portrait = preload("res://Art/debug_joe_portrait.png")
var jane_portrait = preload("res://Art/jane_portrait.png")
var jay_portrait = preload("res://Art/debug_joe_portrait.png")
var jeremie_portrait = preload("res://Art/debug_joe_portrait.png")
var john_portrait = preload("res://Art/john_portrait.png")
var klaus_portrait = preload("res://Art/debug_joe_portrait.png")
var ruby_portrait = preload("res://Art/debug_joe_portrait.png")
var choice_scene = preload("res://UI/choice.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.in_dialouge = true
	scale = Vector2(2, 2)
	position = Vector2(1000, get_viewport_rect().size.x/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not initialized:
		if (text_pages[page][0] == '&'):
			$Speech.text = text_pages[page].erase(0, 1)
		elif (text_pages[page][0] == '?'):
			$Speech.text = text_pages[page].erase(0, 1)
			$Speech.text = text_pages[page].substr(0, text_pages[page].find('['))
			can_move_on = false
		else:
			$Speech.text = text_pages[page]
		_update_identifiers()
		initialized = true


func _physics_process(delta):
	if (can_move_on and (Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("left_click"))):
		page += 1
		if page >= text_pages.size():
			Global.in_dialouge = false
			queue_free()
		else:
			if (text_pages[page][0] == '&'):
				$Speech.text = text_pages[page].erase(0, 1)
			elif (text_pages[page][0] == '?'):
				$Speech.text = text_pages[page].substr(1, text_pages[page].find('[')-1)
				can_move_on = false
			else:
				$Speech.text = text_pages[page]
			_update_identifiers()

func _update_identifiers():
	if (text_pages[page][0] == '&'):
		$Portrait.texture = jane_portrait
		$Name.text = "Jane"
	else:
		if (text_pages[page][0] == '?'):
			choices = text_pages[page].substr(text_pages[page].find('[')+1, text_pages[page].find(']')-text_pages[page].find('[')-1).split(", ")
			var i = 0
			for choice in choices:
				var scene = choice_scene.instantiate()
				scene.position = Vector2(225, -75 - 30*i)
				scene.text = choice
				scene.answered.connect(_on_choice_chosen)
				add_child(scene)
				i += 1
			can_move_on = false
		character = full_name.substr(0, full_name.find("/"))
		if character == "Alex":
			$Portrait.texture = alex_portrait
			$Name.text = "Alex"
		elif character == "Asa":
			$Portrait.texture = asa_portrait
			$Name.text = "Asa"
		elif character == "David":
			$Portrait.texture = david_portrait
			$Name.text = "David"
		elif character == "DebugJoe":
			$Portrait.texture = debug_joe_portrait
			$Name.text = "Debug Joe"
		elif character == "Ivy":
			$Portrait.texture = ivy_portrait
			$Name.text = "Ivy"
		elif character == "Jay":
			$Portrait.texture = jay_portrait
			$Name.text = "Jay"
		elif character == "Jeremie":
			$Portrait.texture = jeremie_portrait
			$Name.text = "Jeremie"
		elif character == "John":
			$Portrait.texture = john_portrait
			$Name.text = "John"
		elif character == "Klaus":
			$Portrait.texture = klaus_portrait
			$Name.text = "Klaus"
		elif character == "Ruby":
			$Portrait.texture = ruby_portrait
			$Name.text = "Ruby"


func _on_choice_chosen(answer):
	print(full_name + "/" + answer)
	Global.player.talk(full_name + "/" + answer)
	queue_free()
