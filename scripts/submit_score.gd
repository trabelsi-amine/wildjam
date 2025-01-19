extends Control

func Submit() -> void:
	$Loading.show()
	(get_tree().root.get_node("LootLocker") as LootLocker).Returner = ChangeName
	(get_tree().root.get_node("LootLocker") as LootLocker).Register()

func ChangeName():
	(get_tree().root.get_node("LootLocker") as LootLocker).CurrentToken = (get_tree().root.get_node("LootLocker") as LootLocker).Response["session_token"]
	(get_tree().root.get_node("LootLocker") as LootLocker).Returner = SubmitScore
	(get_tree().root.get_node("LootLocker") as LootLocker).ChangeName((get_tree().root.get_node("LootLocker") as LootLocker).CurrentToken,$MainPanel/MainMargin/MainElements/Elements/Enter/EnterLine.text)

func SubmitScore():
	(get_tree().root.get_node("LootLocker") as LootLocker).Returner = Return
	(get_tree().root.get_node("LootLocker") as LootLocker).SubmitScore((get_tree().root.get_node("LootLocker") as LootLocker).CurrentToken,snapped((get_tree().root.get_node("LevelManager") as LevelManager).MainScore,1))

func Return() -> void:
	(get_tree().root.get_node("LevelManager") as LevelManager).MainMenu = true
	(get_tree().root.get_node("LevelManager") as LevelManager).Restart()
