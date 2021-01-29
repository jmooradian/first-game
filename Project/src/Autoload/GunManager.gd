extends Node

var pistol = {
	damage = 10,
	numbullets = 10,
	max_numbullets = 10,
	hasgun = false
}


var guns = {
	"pistol": pistol
}


func printer():
	print(pistol.damage)
	print(guns.get("pistol").damage)
	
