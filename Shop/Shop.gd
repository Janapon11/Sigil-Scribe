extends Node2D

export var NPC = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer.hide()
	$NPC.hide()
	$ShopButton.hide()
	if NPC:
		$NPC.show()
		$ShopButton.hide()
	else:
		$NPC.hide()
		if Data.save_data["mission_number"] > 17:
			$ShopButton.show()
			
	if not Data.is_connected("skill_updated", self, "update_items"):
		Data.connect("skill_updated", self, "update_items")
	
	update_items()
	
	if not Data.is_connected("mission_updated", self, "show_btn"):
		Data.connect("mission_updated", self, "show_btn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func show_btn():
	if NPC:
		return
	if "shop" in Data.save_data:
			if Data.save_data["shop"]:
				$ShopButton.show()


func _on_ShopButton_pressed():
	get_tree().paused = true
	$CanvasLayer.show()



func _on_CloseButton_pressed():
	get_tree().paused = false
	$CanvasLayer.hide()
	if not NPC:
		$ShopButton.show()
	if "djump" in Data.save_data["player_skills"]:
		if not "First Exchange" in Data.save_data["ach"]:
			Data.achieved("First Exchange")


func _on_DjumpBootsBtn_pressed():
	if Data.save_data["gold"] < 100:
		$CanvasLayer/NinePatchRect/InstructionLabel.text = "Not Enough Gold."
		$CanvasLayer/NinePatchRect/InstructionLabel/AnimationPlayer.play("in_out")
		return
	$CanvasLayer/NinePatchRect/confirmation.visible = true
	



func _on_PurchaseConfirmBtn_pressed():
	Data.save_data["player_skills"].append("djump")
	$CanvasLayer/NinePatchRect/confirmation.visible = false
	update_items()
	Data.emit_signal("skill_updated")
	$CanvasLayer/NinePatchRect/NinePatchRect/DjumpBootsBtn.visible = false
	Data.change_gold(-100)
	if Data.save_data["mission_number"] == 18:
		Data.advance_mission()


func _on_PurchaseCancelBtn_pressed():
	$CanvasLayer/NinePatchRect/confirmation.visible = false

func update_items():
	if "djump" in Data.save_data["player_skills"]:
		$CanvasLayer/NinePatchRect/NinePatchRect/DjumpBootsBtn.visible = false
