extends Label

func _ready():
	$AnimationPlayer.play("RESET")
	if not Data.is_connected("achieved", self, "achieved"):
		Data.connect("achieved", self, "achieved")

func achieved(label):
	$AnimationPlayer.stop()
	$".".text = "Achived: " + label
	$AnimationPlayer.play("fade-out")
