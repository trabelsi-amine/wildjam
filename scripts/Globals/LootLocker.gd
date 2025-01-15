extends Node

var Request:HTTPRequest
var GameKey := "dev_341429c8f61b47a78dd1b24dc0dc2b23" #"dev_68638597abb444498ae5dc899ec6a355"
var DomainKey := "731g6j8c" #<- This is testing code. Real: 4ct5pfp1
var GameVersion := "0.10.0.0"
var Response
var Returner:Callable
var LeaderboardID := "26047"

func _ready() -> void:
	var request:HTTPRequest = HTTPRequest.new()
	request.name = "lootlocker"
	request.connect("request_completed",RequestComplete)
	add_child(request)
	Request = request
	
	# Testing
	Returner = Callable.create(self,"g1")
	#Register("testiktestik","halinasalina",true)
	Returner = Callable.create(self,"t")
	MembersLeaderboard("08b177658cf1565b70109e4ecaa8071698dc3eee",5)
func t():
	pass

func RequestComplete(result, response_code, headers, body:PackedByteArray):
	var json:JSON = JSON.new()
	json.parse(body.get_string_from_utf8())
	Response = json.get_data()
	print("response")
	print(Response)
	Returner.call()

func Register(email:String,paswd:String,development:bool):
	return Request.request("https://api.lootlocker.io/white-label-login/sign-up",["domain-key: " + DomainKey,"is-development: " + str(development),"Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"email\": \""+email+"\", \"password\": \""+paswd+"\"}")
func Login(email:String,paswd:String,development:bool):
	return Request.request("https://api.lootlocker.io/white-label-login/login",["domain-key: " + DomainKey,"is-development: " + str(development),"Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"email\": \""+email+"\", \"password\": \""+paswd+"\", \"remember\": true}")
func CreateSession(email:String,token:String):
	return Request.request("https://api.lootlocker.io/game/v2/session/white-label",["Content-Type: application/json"],HTTPClient.METHOD_POST,"{\"game_key\": \""+GameKey+"\", \"email\": \""+email+"\", \"token\": \""+token+"\", \"game_version\": \""+GameVersion+"\"}")
func MembersLeaderboard(token:String,count:int):
	return Request.request("https://api.lootlocker.io/game/leaderboards/"+LeaderboardID+"/list?count="+str(count),["x-session-token: " + token],HTTPClient.METHOD_GET)
