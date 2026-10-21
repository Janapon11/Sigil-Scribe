extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var location_name = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Label.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if $CanvasLayer/Timer.is_stopped():
			$CanvasLayer/Label.text = location_name
			$CanvasLayer/Label.show()
			$CanvasLayer/Label/AnimationPlayer.stop()
			$CanvasLayer/Label/AnimationPlayer.play("fade")
			$CanvasLayer/Timer.start()
		pass
	
	pass # Replace with function body.
	
func _notification(what):
	match what:
		NOTIFICATION_PAUSED:
			$CanvasLayer/Label.hide()

