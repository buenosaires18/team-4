extends Node2D

onready var nd_home_screen = get_node("nd_home_screen")
onready var anp_home = get_node("anp_home")

func _ready():
	anp_home.play("view_controls")
	
	nd_home_screen.connect("hidden_control", self, "hidden_control", [], 0)
	nd_home_screen.connect("view_control", self, "view_control", [], 0)

func hidden_control():
	anp_home.play_backwards("view_controls")

func view_control():
	anp_home.play("view_controls")