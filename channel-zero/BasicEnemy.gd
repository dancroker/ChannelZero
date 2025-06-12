extends Enemy

class_name BasicEnemy
#character Model
func _ready():
	Model = preload("res://Characters/EnemyBasic.tscn")

func Move(start,target,matrix):
	pass
func Attack():
	pass
