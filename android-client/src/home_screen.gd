extends Node2D

# Variable que indicara el estado modal se esta quitando.
enum {PRINCIPAL_STATE, TRAINING_STATE, MAKE_QUESTION}
# Variables de los componentes que hacen al nodo.
onready var txb_ask = get_node("txb_ask")
onready var txb_response = get_node("txb_response")
onready var txb_training_1 = get_node("nd_ask/txb_training_1")
onready var txb_training_2 = get_node("nd_ask/txb_training_2")
onready var txb_training_3 = get_node("nd_ask/txb_training_3")
onready var txb_send = get_node("nd_ask/txb_send")
onready var txb_back = get_node("txb_back")
onready var an_player = get_node("an_player")

# Variable que mantiene el estado en que se encuentra el modal.
var state_modal

func _ready():
	# Conecto los eventos de precionar de los botones a los metodos.
	txb_ask.connect("pressed", self, "go_training", [], 0)
	txb_response.connect("pressed", self, "go_question", [], 0)
	txb_training_1.connect("pressed", self, "go_make_question", [], 0)
	txb_training_2.connect("pressed", self, "go_make_question", [], 0)
	txb_training_3.connect("pressed", self, "go_make_question", [], 0)
	txb_send.connect("pressed", self, "send_question", [], 0)
	txb_back.connect("pressed", self, "back_modal", [], 0)
	
	disable_signal(true)
	view_modal()

# Muestro la pantalla principal.
func view_modal():
	an_player.connect("finished", self, "end_animation_intro", [], 0)
	an_player.play("view_modal")

# Llamado desde view_modal.
func end_animation_intro():
	state_modal = PRINCIPAL_STATE
	disable_signal(false)

# Bloquea los botones.
func disable_signal(p_state):
	txb_back.set_block_signals(p_state)
	txb_response.set_block_signals(p_state)
	txb_training_1.set_block_signals(p_state)
	txb_training_2.set_block_signals(p_state)
	txb_training_3.set_block_signals(p_state)
	txb_send.set_block_signals(p_state)
	txb_back.set_block_signals(p_state)

# Envio la pregunta y llamo una pantalla de confirmacion.
func send_question():
	disable_signal(true)
	an_player.connect("finished", self, "end_back_to_home", [], 0)
	an_player.play_backwards("make_question")

func end_back_to_home():
	an_player.disconnect("finished", self, "end_back_to_home")
	view_modal()

# Pantalla que permite crear una pregunta.
func go_make_question():
	disable_signal(true)
	an_player.connect("finished", self, "end_animation_question", [], 0)
	an_player.play_backwards("view_training")
	an_player.queue("make_question")

# Llamado desde go_make_question para hacer una pregunta.
func end_animation_question():
	state_modal = MAKE_QUESTION
	an_player.disconnect("finished", self, "end_animation_question")
	disable_signal(false)

# Metodo que muestra las preguntas a responder.
func go_question():
	pass

# Muestra los cursos.
func go_training():
	disable_signal(true)
	an_player.connect("finished", self, "end_animation_training", [], 0)
	an_player.play_backwards("view_modal")
	an_player.queue("view_training")

# Es llamado desde el go_training.
func end_animation_training():
	state_modal = TRAINING_STATE
	an_player.disconnect("finished", self, "end_animation_training")
	disable_signal(false)

# Metodo que retorna al menu principal.
func back_to_principal():
	disable_signal(true)
	an_player.connect("finished", self, "end_animation_intro", [], 0)
	an_player.play_backwards("view_training")
	an_player.queue("view_modal")

func back_to_training():
	disable_signal(true)
	an_player.connect("finished", self, "end_animation_training", [], 0)
	an_player.play_backwards("make_question")
	an_player.queue("view_training")

# Metodo que gestiona las pantallas al querer volver.
func back_modal():
	if state_modal == PRINCIPAL_STATE:
		pass
	elif state_modal == TRAINING_STATE:
		back_to_principal()
	elif state_modal == MAKE_QUESTION:
		back_to_training()