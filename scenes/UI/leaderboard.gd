extends Control

func Players(items:Array):
	var counter := 1
	for i in items:
		var plr = $MainPanel/MainMargin/MainElements/Leaderboard/Scroll/Players/Temp.duplicate()
		plr.name = str(counter)
		(plr.get_node("HBoxContainer/Rank") as Label).text = str(i["rank"])
		(plr.get_node("HBoxContainer/Score") as Label).text = str(i["score"]) + " s"
		(plr.get_node("HBoxContainer/Name") as Label).text = i["player"]["name"] 
		(plr as PanelContainer).show()
		$MainPanel/MainMargin/MainElements/Leaderboard/Scroll/Players.add_child(plr)
		counter += 1
