extends Node2D
func _ready():
	print("Hello, world!")
	var Map = []
	for i in range(10):
		var row = []
		for j in range(10):
			row.append("+")
		Map.append(row)
	print(Map) #
	print("test")
