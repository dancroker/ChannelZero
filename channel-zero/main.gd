extends Node2D
func _ready():
	print("Hello, world!")
	var Map = []
	for i in range(10):
		var row = []
		for j in range(10):
			row.append("o")
		Map.append(row)
	print(Map) #Create a 10x10 matrix
