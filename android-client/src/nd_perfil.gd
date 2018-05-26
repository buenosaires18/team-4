extends Node2D

onready var txb_confirm = get_node("txb_confirm")
onready var txb_back = get_node("txb_back")
onready var anp_perfil = get_node("anp_perfil")

signal quit_modal

func _ready():
	txb_confirm.connect("pressed", self, "confirm_information", [], 0)
	txb_back.connect("pressed", self, "back_to_principal", [], 0)

func view_perfil():
	anp_perfil.play("view_perfil")

func back_to_principal():
	remove_perfil()

func confirm_information():
	####
	# Aca deberia comunicarse con la API y enviar la confirmacion de la informacion.
	####
	remove_perfil()

func remove_perfil():
	anp_perfil.connect("finished", self, "end_animation_remove", [], 0)
	anp_perfil.play_backwards("view_perfil")

func end_animation_remove():
	anp_perfil.disconnect("finished", self, "end_animation_remove")
	emit_signal("quit_modal")