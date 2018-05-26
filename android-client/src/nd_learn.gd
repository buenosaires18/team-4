extends Node2D

onready var txb_training_1 = get_node("txb_training_1")
onready var txb_training_2 = get_node("txb_training_2")
onready var txb_back = get_node("txb_back")
onready var anp_learn = get_node("anp_learn")

signal quit_modal

func _ready():
	txb_back.connect("pressed", self, "remove_modal", [], 0)

func view_modal():
	anp_learn.play("view_learn")

func remove_modal():
	anp_learn.connect("finished", self, "end_remove_modal", [], 0)
	anp_learn.play_backwards("view_learn")

func end_remove_modal():
	anp_learn.disconnect("finished", self, "end_remove_modal")
	emit_signal("quit_modal")