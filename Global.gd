extends Node

signal health_change


var got_key : bool = false

var health = 3 :
	set(value):
		health = value
		health_change.emit()
		





