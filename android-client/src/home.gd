extends Node2D

onready var nd_home_screen = get_node("nd_home_screen")
onready var anp_home = get_node("anp_home")
onready var txb_feedback = get_node("txb_feedback")
onready var txb_notification = get_node("txb_notification")
onready var txb_profile = get_node("txb_profile")
onready var nd_feedback = get_node("nd_feedback")
onready var spr_logo = get_node("spr_logo")
onready var nd_perfil = get_node("nd_perfil")
onready var spr_score = get_node("spr_score")
onready var nd_notification = get_node("nd_notification")

func _ready():
	anp_home.play("view_controls")
	nd_home_screen.connect("hidden_control", self, "hidden_control", [], 0)
	nd_home_screen.connect("view_control", self, "view_control", [], 0)
	txb_feedback.connect("pressed", self, "go_to_feedback", [], 0)
	txb_notification.connect("pressed", self, "go_to_notification", [], 0)
	txb_profile.connect("pressed", self, "go_to_profile", [], 0)

# Metodo llamado desde el home_screen, agrega acoplamiento. ver para mejorar.
func hidden_head(p_state):
	spr_logo.set_hidden(p_state)
	spr_score.set_hidden(p_state)

func hidden_control():
	anp_home.play_backwards("view_controls")

func view_control():
	anp_home.play("view_controls")

func go_to_notification():
	# Oculto el modal principal.
	nd_home_screen.connect("hidden_principal", self, "view_notification", [], 0)
	nd_home_screen.hidden_principal()
	hidden_control()
	spr_logo.set_hidden(true)
	spr_score.set_hidden(true)

func view_notification():
	nd_home_screen.disconnect("hidden_principal", self, "view_notification")
	nd_notification.connect("quit_modal", self, "view_principal", [], 0)
	nd_notification.connect("view_mensagge", self, "go_to_profile", [], 0)
	nd_notification.view_modal()

func go_to_profile():
	# Oculto el modal principal.
	nd_notification.disconnect("view_mensagge", self, "go_to_profile")
	nd_home_screen.connect("hidden_principal", self, "view_profile", [], 0)
	nd_home_screen.hidden_principal()
	hidden_control()
	spr_logo.set_hidden(true)
	spr_score.set_hidden(true)

func view_profile():
	nd_home_screen.disconnect("hidden_principal", self, "view_profile")
	nd_perfil.connect("quit_modal", self, "view_principal", [], 0)
	nd_perfil.view_perfil()

func go_to_feedback():
	# Oculto el modal principal.
	nd_home_screen.connect("hidden_principal", self, "view_feedback", [], 0)
	nd_home_screen.hidden_principal()
	hidden_control()
	spr_logo.set_hidden(true)
	spr_score.set_hidden(true)

func view_feedback():
	nd_home_screen.disconnect("hidden_principal", self, "view_feedback")
	nd_feedback.connect("quit_modal", self, "view_principal", [], 0)
	nd_feedback.view_modal()

func view_principal():
	nd_notification.disconnect("view_mensagge", self, "view_principal")
	nd_notification.disconnect("quit_modal", self, "view_principal")
	nd_feedback.disconnect("quit_modal", self, "view_principal")
	nd_perfil.disconnect("quit_modal", self, "view_principal")
	view_control()
	spr_logo.set_hidden(false)
	spr_score.set_hidden(false)
	nd_home_screen.view_modal()