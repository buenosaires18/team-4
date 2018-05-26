extends Node2D

onready var nd_home_screen = get_node("nd_home_screen")
onready var anp_home = get_node("anp_home")
onready var txb_feedback = get_node("txb_feedback")
onready var nd_feedback = get_node("nd_feedback")
onready var spr_logo = get_node("spr_logo")

func _ready():
	anp_home.play("view_controls")
	
	nd_home_screen.connect("hidden_control", self, "hidden_control", [], 0)
	nd_home_screen.connect("view_control", self, "view_control", [], 0)
	txb_feedback.connect("pressed", self, "go_to_feedback", [], 0)

func hidden_control():
	anp_home.play_backwards("view_controls")

func view_control():
	anp_home.play("view_controls")

func go_to_feedback():
	# Oculto el modal principal.
	nd_home_screen.connect("hidden_principal", self, "view_feedback", [], 0)
	nd_home_screen.hidden_principal()
	hidden_control()
	spr_logo.set_hidden(true)

func view_feedback():
	nd_home_screen.disconnect("hidden_principal", self, "view_feedback")
	nd_feedback.connect("quit_modal", self, "view_principal", [], 0)
	nd_feedback.view_modal()

func view_principal():
	nd_feedback.disconnect("quit_modal", self, "view_principal")
	view_control()
	spr_logo.set_hidden(false)
	nd_home_screen.view_modal()