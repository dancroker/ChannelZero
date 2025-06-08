extends Node2D

var Rows := 0
var Cols := 0
var Map = []
var Visited = []

func _ready():
	var generated_map = GenerateMap(20, 20, 250)
	PrintMap(generated_map)
	print("Done!")

func PathThroughMap(pMap):
	Map = pMap
	Rows = Map.size()
	Cols = Map[0].size()
	Visited = []
	for r in range(Rows):
		var Row = []
		for c in range(Cols):
			Row.append(false)
		Visited.append(Row)
	
	var Result = SearchAlgorithm(0, 0) #Change this to change start of Search!
	return [Result, Visited]

func SearchAlgorithm(x, y) -> bool:
	if x < 0 or y < 0 or x >= Rows or y >= Cols:
		return false
	if Map[x][y] == '#':
		return false
	if Visited[x][y]:
		return false
	if x == Rows - 1 and y == Cols - 1:
		return true
	Visited[x][y] = true
	if SearchAlgorithm(x + 1, y):
		return true
	if SearchAlgorithm(x - 1, y):
		return true
	if SearchAlgorithm(x, y + 1):
		return true
	if SearchAlgorithm(x, y - 1):
		return true
	return false

func PrintMap(Map):
	for Row in Map:
		print(" ".join(Row))

func FormRandomMap(RowCount, ColCount):
	var Map = []
	var Rand = RandomNumberGenerator.new()
	Rand.randomize()
	for r in range(RowCount):
		var Row = []
		for c in range(ColCount):
			if Rand.randi_range(0, 4) == 1:
				Row.append("#")
			else:
				Row.append(".")
		Map.append(Row)
	var output = PathThroughMap(Map)
	var Result = output[0]
	var Visited = output[1]
	for x in range(RowCount):
		for y in range(ColCount):
			if Map[x][y] == "." and Visited[x][y] == false:
				Map[x][y] = "#"
	return Map

func MapValueCount(Map, MapValue):
	var PathCounter = 0
	for x in range(Map.size()):
		for y in range(Map[0].size()):
			if Map[x][y] == MapValue:
				PathCounter += 1
	return PathCounter

func SpawnLocations(Map, SpawnLocationCount):
	while MapValueCount(Map, "o") != SpawnLocationCount:
		for x in range(Map.size() - 1, -1, -1):
			for y in range(Map[0].size() - 1, -1, -1):
				if Map[x][y] == ".":
					if MapValueCount(Map, "o") == SpawnLocationCount:
						pass
					else:
						Map[x][y] = "o"

func GenerateMap(RowCount, ColCount, PathCount):
	var Map = []
	while MapValueCount(Map, ".") != PathCount:
		Map = FormRandomMap(RowCount, ColCount)
	SpawnLocations(Map, 3)
	return Map
