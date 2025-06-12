extends Node2D

var Rows := 0
var Cols := 0
var Map = []
var Visited = []

func _ready():
	var generated_map = GenerateMap(12, 12, 110)
	PrintMap(generated_map)
	DisplayTeam()
	var enemy_instance = Enemy.new()
	#enemy_instance.test()
	add_child(enemy_instance)  
	enemy_instance.DrawSelf(Map)

func DisplayTeam():
	const TilePush = 78.5 #Vector distance between middle of tiles
	var Team = LoadPlayer(0)
	var Member1 = Team[0]
	var Member1Location = [0,0]
	var Placed = false
	for x in range(len(Map)):
		for y in range(len(Map[0])):
			if Map[x][y] == "o" and Placed == false:
				Member1.global_position = Vector2(42+(TilePush*y), 36+(TilePush*x))
				Member1.scale = Vector2(4.91, 4.91)
				Member1Location = [y,x]
				Placed = true

func LoadPlayer(Member1File):
	var Member1Scene = preload("res://Characters/RedKnight.tscn")
	var Member1 = Member1Scene.instantiate()
	add_child(Member1)
	return[Member1]


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

func EnemySpawnLocations(Map, SpawnLocationCount):
	while MapValueCount(Map, "x") != SpawnLocationCount:
		for x in range(Map.size() - 1, -1, -1):
			for y in range(Map[0].size() - 1, -1, -1):
				if Map[x][y] == ".":
					if MapValueCount(Map, "x") == SpawnLocationCount:
						pass
					else:
						Map[x][y] = "x"

func PlayerSpawnLocations(Map, SpawnLocationCount):
	while MapValueCount(Map, "o") != SpawnLocationCount:
		for x in range(Map.size()):
			for y in range(Map[0].size()):
				if Map[x][y] == ".":
					if MapValueCount(Map, "o") == SpawnLocationCount:
						pass
					else:
						Map[x][y] = "o"

func GenerateMap(RowCount, ColCount, PathCount):
	var Map = []
	var IsThereExitLocation = false
	Map = FormRandomMap(RowCount, ColCount)
	while (MapValueCount(Map, ".") != (PathCount-1) or IsThereExitLocation == false): #-1 for the spawn locaton
		Map = FormRandomMap(RowCount, ColCount)
		IsThereExitLocation = false
		for x in range(len(Map)-1,0,-1):
			if Map[x][len(Map[0])-1] == "." and IsThereExitLocation == false:
				Map[x][len(Map[0])-1] = "@"
				IsThereExitLocation = true
		for y in range(len(Map[0])-1,0,-1):
			if Map[len(Map)-1][y] == "." and IsThereExitLocation == false:
				Map[len(Map)-1][y]= "@"
				IsThereExitLocation = true
				
				
	PlayerSpawnLocations(Map,1)
	EnemySpawnLocations(Map, 5)
	$TileMap/MapRender.draw_map_visual(Map)
	$TileMap.scale = Vector2(4.91, 4.91)
	#$TileMap.position = Vector2(250, 0)
	return Map
