extends ProgressBar

var sb = StyleBoxFlat.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("29D07C")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if value == 60:
		sb.bg_color = Color("FFFF00")
		
	if value == 20:
		sb.bg_color = Color("FF0000")
