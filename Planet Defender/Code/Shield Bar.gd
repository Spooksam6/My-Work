extends ProgressBar

var sb = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("63e5ff")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
  
