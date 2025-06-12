extends Node2D

class_name Enemy

#basic stats:
var Health = 1
var MoveDistance = 1
var Damage = 1

#Model is the res:// link to character visuals
var Model = "res://Characters/EnemyBasic.tscn"

func test():
	print("Test")

func Move(start,target,matrix):
	pass
	

func Attack():
	pass

func LoadPlayer(Model):
	var Member1Scene = load(Model)
	var Member1 = Member1Scene.instantiate()
	add_child(Member1)
	return Member1

func PositionSelf(Member1,Map):
	const TilePush = 78.5 #Vector distance between middle of tile
	#var Member1 = Model
	var Member1Location = [0,0]
	var Placed = false
	for x in range(len(Map)):
		for y in range(len(Map[0])):
			if Map[x][y] == "x" and Placed == false:
				Member1.global_position = Vector2(42+(TilePush*y), 36+(TilePush*x))
				Member1.scale = Vector2(4.91, 4.91)
				Member1Location = [y,x]
				Placed = true
				Map[x][y] = "@"
				print("hey!")

func DrawSelf(Map):
	PositionSelf(LoadPlayer(Model),Map)
