extends Node

var Request:HTTPRequest
var GameKey := "dev_341429c8f61b47a78dd1b24dc0dc2b23" #<- This is testing code. Real:"prod_5252f7a22f944b08ae30f8ea1dde1db0"
var DomainKey := "731g6j8c" #<- This is testing code. Real: 4ct5pfp1
var GameVersion := "0.10.0.0"
var Response
var Returner:Callable
var LeaderboardID := "26047" #<- This is testing code. Real: 27012
var CurrentToken

func _ready() -> void:
	var request:HTTPRequest = HTTPRequest.new()
	request.name = "lootlocker"
	request.connect("request_completed",RequestComplete)
	add_child(request)
	Request = request

func RequestComplete(_result, _response_code, _headers, body:PackedByteArray):
	var json:JSON = JSON.new()
	json.parse(body.get_string_from_utf8())
	Response = json.get_data()
	print(Response)
	Returner.call()

func Register():
	return Request.request("https://api.lootlocker.io/game/v2/session/guest",["Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"game_key\": \""+GameKey+"\", \"game_version\": \"0.10.0.0\"}")
func Login(id:String):
	return Request.request("https://api.lootlocker.io/game/v2/session/guest",["Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"game_key\": \""+GameKey+"\", \"player_identifier\": \""+id+"\", \"game_version\": \"0.10.0.0\"}")
func MembersLeaderboard(token:String,count:int):
	return Request.request("https://api.lootlocker.io/game/leaderboards/"+LeaderboardID+"/list?count="+str(count),["x-session-token: " + token],HTTPClient.METHOD_GET)
func SubmitScore(token:String,score:int):
	return Request.request("https://api.lootlocker.io/game/leaderboards/"+LeaderboardID+"/submit",["x-session-token: " + token,"Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"score\": "+str(score)+"}")
func ChangeName(token:String,player_name:String):
	return Request.request("https://api.lootlocker.io/game/player/name",["x-session-token: " + token, "LL-Version: 2021-03-01","Content-Type: application/json"],HTTPClient.METHOD_PATCH,"{\"name\": \""+player_name+"\"}")
