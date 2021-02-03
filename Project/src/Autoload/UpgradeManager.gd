extends Node

var healthUpgrades = [500, 1000, 2000, 4000]
var speedUpgrades = [500, 1000, 2000, 4000]
var jumpUpgrades = [500, 1000, 2000, 4000]
var gunUpgrades = [500, 1000, 2000, 4000]
var shieldUpgrades = [500, 1000, 2000, 4000]

#sample for upgrade dictionary
var health = {
	price = [500, 1000, 2000, 4000],
	description = ["+5%", "+10%", "+15%", "+20%"],
	effect = [105, 110, 115, 120],
	
	#Increase ______ by 5%
	# +y%
}

var speed = {
	price = [500, 1000, 2000, 4000]
}

var jump = {
	price = [500, 1000, 2000, 4000]
}

var gun = {
	price = [500, 1000, 2000, 4000]
}

var pistol = {
	price = [500, 1000, 2000, 4000]
}
var shotgun = {
	price = [500, 1000, 2000, 4000]
}
var rifle = {
	price = [500, 1000, 2000, 4000]
}
var rocketlauncher = {
	price = [500, 1000, 2000, 4000]
}

var shield = {
	price = [500, 1000, 2000, 4000]
}

var heavyfeet = {
	price = [2000],
	description = ["Player stomp damage is increased"],
	effect = [150]
}


var upgrades = {
	"health": health,
	"speed": speed,
	"jump": jump,
	"gun": gun,
	"pistol": pistol,
	"shotgun": shotgun,
	"rifle": rifle,
	"rocketlauncher": rocketlauncher,
	"shield": shield,
	"heavyfeet": heavyfeet
}
