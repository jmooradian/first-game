extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (Color) var gain_health
export (Color) var lose_health
export (float, 0, 1, 0.05) var caution_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2

onready var g_health = gain_health
onready var l_health = lose_health

#Change color depending on health------------------------------------
func _assign_color(health):
	if health < health_over.max_value * danger_zone:
		health_over.tint_progress = danger_color
	elif health < health_over.max_value * caution_zone:
		health_over.tint_progress = caution_color
	else:
		health_over.tint_progress = healthy_color
#--------------------------------------------------------------------

#Health Updates------------------------------------------------------
func update_max_health(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health

func update_health(health):
	if health_over.value > health:
		health_under.tint_progress = l_health
		health_over.value = health
		update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	elif health_over.value < health:
		health_under.tint_progress = g_health
		health_under.value = health
		update_tween.interpolate_property(health_over, "value", health_over.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	
	update_tween.start()
	
	_assign_color(health)
#--------------------------------------------------------------------
