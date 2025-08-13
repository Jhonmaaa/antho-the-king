extends Node

const SAVE_PATH := "user://savegame.json"

func save_game():
    var data = {
        "villagers": GameState.villagers,
        "unlocked": GameState.unlocked
    }
    var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
    f.store_string(JSON.stringify(data))
    f.close()

func load_game():
    if not FileAccess.file_exists(SAVE_PATH):
        return
    var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
    var data = JSON.parse_string(f.get_as_text())
    f.close()
    if typeof(data) == TYPE_DICTIONARY:
        GameState.villagers = int(data.get("villagers", 0))
        GameState.unlocked = data.get("unlocked", {})
