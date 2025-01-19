extends Control

func Players(items:Array):
	var counter := 1
	for i in items:
		var plr = $MainPanel/MainMargin/Split/MainElements/Leaderboard/Scroll/Players/Temp.duplicate()
		plr.name = str(counter)
		(plr.get_node("HBoxContainer/Rank") as Label).text = str(i["rank"])
		(plr.get_node("HBoxContainer/Score") as Label).text = str(i["score"])
		(plr.get_node("HBoxContainer/Name") as Label).text = i["player"]["name"]
		(plr as PanelContainer).show()
		$MainPanel/MainMargin/Split/MainElements/Leaderboard/Scroll/Players.add_child(plr)
		counter += 1

func ShowLead():
	$MainPanel/MainMargin/Split/MainElements/Leaderboard/Scroll.hide()
	$MainPanel/MainMargin/Split/MainElements/Leaderboard/Loading.show()
	show()
	
	for i in $MainPanel/MainMargin/Split/MainElements/Leaderboard/Scroll/Players.get_children():
		if i.name != "Temp": i.queue_free()
	(get_tree().root.get_node("LootLocker") as LootLocker).Returner = GetMembers
	(get_tree().root.get_node("LootLocker") as LootLocker).Register()

func GetMembers():
	(get_tree().root.get_node("LootLocker") as LootLocker).Returner = ShowMembers
	(get_tree().root.get_node("LootLocker") as LootLocker).MembersLeaderboard((get_tree().root.get_node("LootLocker") as LootLocker).Response["session_token"],10)

func ShowMembers():
	$MainPanel/MainMargin/Split/MainElements/Leaderboard/Scroll.show()
	$MainPanel/MainMargin/Split/MainElements/Leaderboard/Loading.hide()
	Players((get_tree().root.get_node("LootLocker") as LootLocker).Response["items"])

func Back():
	hide()
