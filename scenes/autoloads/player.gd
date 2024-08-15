extends Node
class_name Player
@export var user = "Traveller"

enum status{flunkered,dreaming,c}
@export var statuscurrent:status =status.flunkered
var statuses = ["Flunkered","Dreaming","c"]
var statusEffects = []



func return_status(stats) ->String:
	statuscurrent = stats
	
	return statuses[statuscurrent]
