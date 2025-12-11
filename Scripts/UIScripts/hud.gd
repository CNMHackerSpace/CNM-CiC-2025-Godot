extends Control

@onready var hp_text = $HPCounter
@onready var ammo_text = $AmmoCounter

func update_hp_text(_new_val:int)->void:
	hp_text.text = "HP: " + str(_new_val)

func update_ammo_text(_new_val:int)->void:
	ammo_text.text = "Ammo: " + str(_new_val) + "/3"
