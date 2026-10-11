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
