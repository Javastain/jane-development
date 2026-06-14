extends Node2D

var text_pages = []
var initialized = false
var page = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2(3, 3)
	position = Vector2(1000, get_viewport_rect().size.x/2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not initialized:
		$Label.text = text_pages[page]
		initialized = true


func _physics_process(delta):
	if (Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("left_click")):
		page += 1
		if page >= text_pages.size():
			queue_free()
		else:
			$Label.text = text_pages[page]
