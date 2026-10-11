extends Node2D

func _ready():
	$current_gold_label.text = str(int(Data.save_data["gold"]))
	$change_current_gold_label.hide()
	
	# Connect signal from Data singleton to this node's update_gold method
	Data.connect("gold_changed", self, "update_gold")
	
	if not str(Data.save_data["player_name"]) == str("Llander"):
		$GoldTest.hide()

func update_gold(amount):
	if amount == 0:
		return
		
	var start_gold = int(Data.save_data["gold"]) - amount # Current value before change
	var target_gold = int(Data.save_data["gold"])
	var remaining_change = amount
	
	$change_current_gold_label.show()
	
	var steps = 20
	var gold_step = amount / float(steps)
	
	if amount > 0:
		$change_current_gold_label.text = "+" + str(int(round(remaining_change)))
	else:
		$change_current_gold_label.text = str(int(round(remaining_change)))
	yield(get_tree().create_timer(1), "timeout")
	
	for i in range(steps):
		start_gold += gold_step
		remaining_change -= gold_step
		
		$current_gold_label.text = str(int(round(start_gold)))
		
		if amount > 0:
			$change_current_gold_label.text = "+" + str(int(round(remaining_change)))
		else:
			$change_current_gold_label.text = str(int(round(remaining_change)))
			
		yield(get_tree().create_timer(0.03), "timeout")
		
	$current_gold_label.text = str(target_gold)
	$change_current_gold_label.text = "0"
	
	yield(get_tree().create_timer(0.2), "timeout")
	$change_current_gold_label.hide()



func _on_add_pressed():
	Data.change_gold(100)


func _on_minus_pressed():
	Data.change_gold(-100)
