extends Node

var pistol = {
	damage = 10,
	numbullets = 10,
	max_numbullets = 10,
	hasgun = false
}

var shotgun = {
	damage = 25,
	numbullets = 10,
	max_numbullets = 10,
	hasgun = false
}

var rifle = {
	damage = 40,
	numbullets = 5,
	max_numbullets = 5,
	hasgun = false
}

var rocketlauncher = {
	damage = 100,
	numbullets = 3,
	max_numbullets = 3,
	hasgun = false
}


var guns = {
	"pistol": pistol,
	"shotgun": shotgun,
	"rifle": rifle,
	"rocketlauncher": rocketlauncher
}


func printer():
	print(pistol.damage)
	print(guns.get("pistol").damage)
	
