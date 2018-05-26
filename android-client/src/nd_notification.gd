extends Node2D


onready var txb_back = get_node("txb_back")
onready var txb_msj_1 = get_node("txb_msj_1")
onready var anp_notification = get_node("anp_notification")

signal quit_modal
signal view_mensagge

func _ready():
	txb_msj_1.connect("pressed", self, "view_mensagge", [], 0)
	txb_back.connect("pressed", self, "remove_modal", [], 0)

func view_mensagge():
	anp_notification.connect("finished", self, "go_to_mensagge", [], 0)
	anp_notification.play_backwards("view_modal")

func go_to_mensagge():
	anp_notification.disconnect("finished", self, "go_to_mensagge")
	emit_signal("view_mensagge")

func remove_modal():
	anp_notification.connect("finished", self, "end_remove_modal", [], 0)
	anp_notification.play_backwards("view_modal")

func end_remove_modal():
	anp_notification.disconnect("finished", self, "end_remove_modal")
	emit_signal("quit_modal")

func view_modal():
	anp_notification.play("view_modal")