extends Node2D

var text_pages = []
var initialized = false
var page = 0
var character = ""

var alex_portrait = preload("res://Art/debug_joe_portrait.png")
var asa_portrait = preload("res://Art/debug_joe_portrait.png")
var david_portrait = preload("res://Art/debug_joe_portrait.png")
var debug_joe_portrait = preload("res://Art/debug_joe_portrait.png")
var ivy_portrait = preload("res://Art/debug_joe_portrait.png")
var jane_portrait = preload("res://Art/jane_portrait.png")
var jay_portrait = preload("res://Art/debug_joe_portrait.png")
var jeremie_portrait = preload("res://Art/debug_joe_portrait.png")
var john_portrait = preload("res://Art/debug_joe_portrait.png")
var klaus_portrait = preload("res://Art/debug_joe_portrait.png")
var ruby_portrait = preload("res://Art/debug_joe_portrait.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(2, 2)
	position = Vector2(1000, get_viewport_rect().size.x/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not initialized:
		if (text_pages[page][0] == '&'):
			$Speech.text = text_pages[page].erase(0, 1)
		else:
			$Speech.text = text_pages[page]
		_update_identifiers()
		initialized = true


func _physics_process(delta):
	if (Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("left_click")):
		page += 1
		if page >= text_pages.size():
			queue_free()
		else:
			if (text_pages[page][0] == '&'):
				$Speech.text = text_pages[page].erase(0, 1)
			else:
				$Speech.text = text_pages[page]
			_update_identifiers()

func _update_identifiers():
	if (text_pages[page][0] == '&'):
		$Portrait.texture = jane_portrait
		$Name.text = "Jane"
	else:
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
