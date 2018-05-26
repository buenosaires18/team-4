extends Node2D

onready var anp_feedback = get_node("anp_feedback")
onready var txb_sent = get_node("txb_sent")
onready var txb_back = get_node("txb_back")
onready var chb_bueno = get_node("chb_bueno")
onready var chb_regular = get_node("chb_regular")
onready var chb_malo = get_node("chb_malo")
onready var txe_coment = get_node("txe_coment")

signal quit_modal

func _ready():
	disable_signal(true)
	txb_back.connect("pressed", self, "quit_modal", [], 0)
	txb_sent.connect("pressed", self, "sent_feedback", [], 0)

func view_modal():
	anp_feedback.connect("finished", self, "end_animation_init", [], 0)
	anp_feedback.play("view_modal")
	txe_coment.set_text("")

func end_animation_init():
	anp_feedback.disconnect("finished", self, "end_animation_init")
	disable_signal(false)

func quit_modal():
	disable_signal(true)
	anp_feedback.connect("finished", self, "end_remove_modal", [], 0)
	anp_feedback.play_backwards("view_modal")

func end_remove_modal():
	anp_feedback.disconnect("finished", self, "end_remove_modal")
	emit_signal("quit_modal")

func sent_feedback():
	####
	# Aca debería comunicarse con la API pasando los datos del formulario.
	####
	
	#Limpio el modal y lo quito.
	txe_coment.set_text("")
	quit_modal()

# Bloquea los botones.
func disable_signal(p_state):
	txb_back.set_block_signals(p_state)
	txb_sent.set_block_signals(p_state)
