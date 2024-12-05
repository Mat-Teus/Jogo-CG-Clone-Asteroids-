extends Label

var score = 0

func _on_player_mob() -> void:
	score += 1
	text = "%s" % score


func _on_player_mob_2() -> void:
	score += 1
	text = "%s" % score


func _on_player_mob_3() -> void:
	score += 1
	text = "%s" % score

func _on_player_mob_4() -> void:
	score += 1
	text = "%s" % score
