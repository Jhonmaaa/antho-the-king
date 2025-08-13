extends Node

var villagers := 0
var unlocked := {"world1_start": true}

func unlock(id:String):
    unlocked[id] = true
    Save.save_game()

func is_unlocked(id:String) -> bool:
    return unlocked.get(id, false)
