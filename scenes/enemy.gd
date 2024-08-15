extends Node
class_name Enemy
@export var enemy = Resource
@export var health = 100
# Called when the node enters the scene tree for the first time.
@export var attacks = []
@export var statusEffects =[]
@onready var sprite = $Sprite

signal died
signal hitted
func _ready():
	sprite.texture = enemy.texture
	CombatManager.affected.connect(apply_effect_status)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func take_damage(val):
	hitted.emit()
	if val < health:
		val =- health
	else:
		died.emit()
		
		
func take_action(_action):
	pass
func apply_effect_status(effect = "",currentPlayer= ""):
	print("applied ",effect," to ",currentPlayer)
