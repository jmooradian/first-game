extends Control

export (Color) var gain_shields
export (Color) var lose_shields

onready var shield_over = $ShieldOver
onready var shield_under = $ShieldUnder
onready var update_tween = $UpdateTween
onready var g_shields = gain_shields
onready var l_shields = lose_shields
onready var label = $ShieldOver/ShieldLabel

func _ready():
	label.text = "%s" % PlayerData.shields

func update_shields(value):
	if shield_over.value > value:
		shield_under.tint_progress = l_shields
		shield_over.value = value
		update_tween.interpolate_property(shield_under, "value", shield_under.value, value, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	elif shield_over.value < value:
		shield_under.tint_progress = g_shields
		shield_under.value = value
		update_tween.interpolate_property(shield_over, "value", shield_over.value, value, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	
	update_tween.start()
	label.text = "%s" % PlayerData.shields

func update_max_shield(value):
	shield_over.max_value = value
	shield_under.max_value = value
