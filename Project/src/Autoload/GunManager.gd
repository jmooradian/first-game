extends Node

var pistol = {
	damage = 10,
	numbullets = 10,
	max_numbullets = 10,
	hasgun = true,
	img = "res://assets/pistol.png"
}

var shotgun = {
	damage = 25,
	numbullets = 10,
	max_numbullets = 10,
	hasgun = true,
	img = "res://assets/shotgun.png"
}

var rifle = {
	damage = 40,
	numbullets = 5,
	max_numbullets = 5,
	hasgun = true,
	img = "res://assets/rifle.png"
}

var rocketlauncher = {
	damage = 100,
	numbullets = 3,
	max_numbullets = 3,
	hasgun = true,
	img = "res://assets/rocketlauncher.png"
}


var guns = {
	"pistol": pistol,
	"shotgun": shotgun,
	"rifle": rifle,
	"rocketlauncher": rocketlauncher
}


func damage(gun: String) -> float:
	return guns.get(gun).damage

func upgrade_damage(gun: String, new_damage: float):
	guns.get(gun).damage += new_damage
