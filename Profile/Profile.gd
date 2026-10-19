extends CanvasLayer

########################### Profile ###########################
onready var profile_details = $ProfileDetails
onready var profile_btn = $ProfileButton

func update_achievements():
	var t1 = $ProfileDetails/Achievements/NinePatchRect/ScrollContainer/AchievementContainer/Title1
	var t2 = $ProfileDetails/Achievements/NinePatchRect/ScrollContainer/AchievementContainer/Title2
	var t3 = $ProfileDetails/Achievements/NinePatchRect/ScrollContainer/AchievementContainer/Title3
	var t4 = $ProfileDetails/Achievements/NinePatchRect/ScrollContainer/AchievementContainer/Title4
	var t5 = $ProfileDetails/Achievements/NinePatchRect/ScrollContainer/AchievementContainer/Title5
	
	if "First Query" in Data.save_data["ach"]:
		t1.visible = true
	else:
		t1.visible = false
	
	if "Logic Starter" in Data.save_data["ach"]:
		t2.visible = true
	else:
		t2.visible = false
	
	if "7-Bit Steak" in Data.save_data["ach"]:
		t3.visible = true
	else:
		t3.visible = false
	
	if "Tutorial Done" in Data.save_data["ach"]:
		t4.visible = true
		$ProfileDetails/BasicDetails/StudentScribeBadge.visible = false
		$ProfileDetails/BasicDetails/NoviceScribeBadge.visible = true
	else:
		t4.visible = false
		$ProfileDetails/BasicDetails/StudentScribeBadge.visible = true
		$ProfileDetails/BasicDetails/NoviceScribeBadge.visible = false
	
	if "First Exchange" in Data.save_data["ach"]:
		t5.visible = true
	else:
		t5.visible = false

func _ready():
	profile_details.visible = false
	#$ProfileButton.normal = "res://player/profile.png"
	
	#Update Name
	$ProfileDetails/BasicDetails/PlayerName.text = Data.save_data["player_name"]
	if $"..".name == "ControlButtons": #if parent is TouchScreen Scene
		pass
	else: #else, currently only Welcome Scene
		profile_btn.visible = false
	
	if not Data.is_connected("skill_updated", self, "update_skills"):
		Data.connect("skill_updated", self, "update_skills")
		
	if not Data.is_connected("achieved", self, "update_achievements"):
		Data.connect("achieved", self, "update_achievements")
	update_achievements()
	update_skills()

func update_skills():
	$ProfileDetails/Skills/DJump.visible = false
	if "djump" in Data.save_data["player_skills"]:
		$ProfileDetails/Skills/DJump.visible = true
	else:
		$ProfileDetails/Skills/DJump.visible = false

func _on_ProfileButton_pressed():
	profile_details.visible = true
	profile_btn.visible = false
	
	if $"..".name == "ControlButtons":
		$"..".visible = false
	
	get_tree().paused = true
	
	update_achievements()
	update_skills()

######################## Profile Details ######################
func _on_TouchScreenButton_pressed():
	profile_details.visible = false
	profile_btn.visible = true

	
	if $"..".name == "ControlButtons":
		$"..".visible = true
	
	_update_Player_Name()
	
	get_tree().paused = false

######################## Basic Details ######################
func _update_Player_Name():
	var playerNameInput = $ProfileDetails/BasicDetails/PlayerName.text
	
	Data.save_data["player_name"] = playerNameInput
	
	print("Player name is updated to: ", Data.save_data["player_name"])



############################# Stats ###########################
onready var upgrage_btn = $ProfileDetails/StatsDetails/Upgrade

onready var spd_pb = $ProfileDetails/StatsDetails/Speed/ProgressBar
onready var spd_edit = $ProfileDetails/StatsDetails/Speed/Upgrade
onready var jmp_ht_pb = $ProfileDetails/StatsDetails/JumpHeight/ProgressBar
onready var jmp_ht_edit = $ProfileDetails/StatsDetails/JumpHeight/Upgrade
onready var gold_yld_pb = $ProfileDetails/StatsDetails/GoldYield/ProgressBar
onready var gold_yld_edit = $ProfileDetails/StatsDetails/GoldYield/Upgrade
onready var exp_yld_pb = $ProfileDetails/StatsDetails/ExpYield/ProgressBar
onready var exp_yld_edit = $ProfileDetails/StatsDetails/ExpYield/Upgrade

onready var upgrading = false

func _on_Upgrade_pressed():
	if not upgrading:
		upgrage_btn.text = "Confirm"
		
		_update_Stats_View()
		upgrading = !upgrading
	else:
		upgrage_btn.text = "Upgrade"
		
		_update_Stats_View()
		upgrading = !upgrading
	pass # Replace with function body.

func _update_Stats_View():
	spd_pb.visible = !spd_pb.visible
	jmp_ht_pb.visible = !jmp_ht_pb.visible
	gold_yld_pb.visible = !gold_yld_pb.visible
	exp_yld_pb.visible = !exp_yld_pb.visible
	
	spd_edit.visible = !spd_edit.visible
	jmp_ht_edit.visible = !jmp_ht_edit.visible
	gold_yld_edit.visible = !gold_yld_edit.visible
	exp_yld_edit.visible = !exp_yld_edit.visible

func _notification(what):
	if what == NOTIFICATION_PAUSED:
		$ProfileButton.visible = false
		print("Game was paused!")
		# Execute code when game pauses (e.g., show pause menu UI)
		
	elif what == NOTIFICATION_UNPAUSED:
		$ProfileButton.visible = true
		print("Game was resumed!")
		# Execute code when game unpauses



