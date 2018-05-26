extends Node2D

# Variable que indicara el estado modal se esta quitando.
enum {PRINCIPAL_STATE, TRAINING_STATE, MAKE_QUESTION, RESPONSE_QUESTION}
# Variables de los componentes que hacen al nodo.
onready var txb_ask = get_node("txb_ask")
onready var txb_response = get_node("txb_response")
onready var txb_training_1 = get_node("nd_ask/txb_training_1")
onready var txb_training_2 = get_node("nd_ask/txb_training_2")
onready var txb_training_3 = get_node("nd_ask/txb_training_3")
onready var txb_send = get_node("nd_ask/txb_send")
onready var txb_back = get_node("txb_back")
onready var an_player = get_node("an_player")
onready var txb_learn = get_node("txb_learn")
onready var txb_confirmed = get_node("nd_response/txb_confirmed")
onready var txe_question = get_node("nd_response/TextEdit")
onready var lbl_ask = get_node("nd_response/lbl_ask")
onready var txe_ask = get_node("nd_ask/TextEdit")
onready var nd_learn = get_node("nd_learn")

# Variable que mantiene el estado en que se encuentra el modal.
var state_modal

signal hidden_control
signal view_control
signal hidden_principal

func _ready():
	# Conecto los eventos de precionar de los botones a los metodos.
	txb_ask.connect("pressed", self, "go_training", [], 0)
	txb_response.connect("pressed", self, "go_question", [], 0)
	txb_learn.connect("pressed", self, "go_learn", [], 0)
	txb_training_1.connect("pressed", self, "go_make_question", [], 0)
	txb_training_2.connect("pressed", self, "go_make_question", [], 0)
	txb_training_3.connect("pressed", self, "go_make_question", [], 0)
	txb_send.connect("pressed", self, "send_question", [], 0)
	txb_back.connect("pressed", self, "back_modal", [], 0)
	txb_confirmed.connect("pressed", self, "send_response", [], 0)
	
	disable_signal(true)
	view_modal()
	set_process_input(true)

# Muestro la pantalla principal.
func view_modal():
	an_player.connect("finished", self, "end_animation_intro", [], 0)
	an_player.play("view_modal")

# Llamado desde view_modal.
func end_animation_intro():
	state_modal = PRINCIPAL_STATE
	an_player.disconnect("finished", self, "end_animation_intro")
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
	# Bloqueo los botones.
	disable_signal(true)
	####
	# Aca deberia esta el metodo que envie la pregunta al server.
	####
	# Limpio el componente.
	txe_ask.set_text("")
	# Emito la señal que avisa al padre que puede volver a mostrar los controles del home.
	emit_signal("view_control")
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

# Metodo que muestra los cursos extras.
func go_learn():
	# Bloqueo los botones.
	disable_signal(true)
	# Emito la señal para ocultar los botones del padre.
	emit_signal("hidden_control")
	# Malisimo. se debera mejorar.
	get_parent().hidden_head(true)
	
	an_player.connect("finished", self, "end_animation_principal", [], 0)
	an_player.play_backwards("view_modal")

func end_animation_principal():
	an_player.disconnect("finished", self, "end_animation_principal")
	nd_learn.connect("quit_modal", self, "back_to_principal", [], 0)
	nd_learn.view_modal()

# Metodo que muestra las preguntas a responder.
func go_question():
	# Bloqueo los botones.
	disable_signal(true)
	# Emito señal para que el padre(home) oculte los controles.
	emit_signal("hidden_control")
	# Limpio componente.
	txe_question.set_text("")
	#####
	# Aca es donde carga la pregunta de la comunidad que le corresponde para el usuario.
	#####
	load_question()
	# Ejecuto la animacion que oculta los botones principales y muestro la entrada de los cursos.
	an_player.connect("finished", self, "end_animation_response", [], 0)
	an_player.play_backwards("view_modal")
	an_player.queue("response_ask")

func end_animation_response():
	state_modal = RESPONSE_QUESTION
	an_player.disconnect("finished", self, "end_animation_response")
	disable_signal(false)

func load_question():
	####
	# Estas preguntas serian devueltas por la API.
	####
	# Metodo que me devuelve un entero del 0 al 2.
	var entero = randi()% 3
	if entero == 0:
		lbl_ask.set_text("Buenas tardes. ¿Cuál es la diferencia entre test de integración y uno de back end?")
	elif entero == 1:
		lbl_ask.set_text("Buenos dias. ¿Cada uno de los elementos de un array estan en posiciones de memoria subsecuentes? ")
	elif entero == 2:
		lbl_ask.set_text("Buenas noches. ¿Como puedo eliminar un registro en una base de datos MySQL?")

# Muestra los cursos.
func go_training():
	# Bloqueo los botones.
	disable_signal(true)
	# Emito la señal para ocultar los botones del padre.
	emit_signal("hidden_control")
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
	# Malisimo. se debera mejorar.
	get_parent().hidden_head(false)
	
	disable_signal(true)
	nd_learn.disconnect("quit_modal", self, "back_to_principal")
	emit_signal("view_control")
	an_player.disconnect("finished", self, "back_to_principal")
	an_player.connect("finished", self, "end_animation_intro", [], 0)
	an_player.play("view_modal")

# Metodo que me lleva a la pantalla de los cursos.
func back_to_training():
	disable_signal(true)
	an_player.connect("finished", self, "end_animation_training", [], 0)
	an_player.play_backwards("make_question")
	an_player.queue("view_training")

# Metodo que envia la respuesta de la pregunta.
func send_response():
	# Bloqueo los botones.
	disable_signal(true)
	####
	# Aca deberia esta el metodo que envie la pregunta al server.
	####
	# Limpio el componente.
	txe_question.set_text("")
	# Emito la señal que avisa al padre que puede volver a mostrar los controles del home.
	emit_signal("view_control")
	an_player.connect("finished", self, "end_back_to_home", [], 0)
	an_player.play_backwards("response_ask")

func hidden_principal():
	disable_signal(true)
	an_player.connect("finished", self, "end_remove_principal", [], 0)
	an_player.play_backwards("view_modal")

func end_remove_principal():
	an_player.disconnect("finished", self, "end_remove_principal")
	emit_signal("hidden_principal")
	disable_signal(false)

# Metodo que gestiona las pantallas al querer volver.
func back_modal():
	if state_modal == PRINCIPAL_STATE:
		pass
	elif state_modal == TRAINING_STATE:
		an_player.connect("finished", self, "back_to_principal", [], 0)
		an_player.play_backwards("view_training")
	elif state_modal == MAKE_QUESTION:
		back_to_training()
	elif state_modal == RESPONSE_QUESTION:
		an_player.connect("finished", self, "back_to_principal", [], 0)
		an_player.play_backwards("response_ask")
