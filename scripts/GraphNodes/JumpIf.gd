extends GraphNode

@onready var main = get_tree().root.get_node("new_main")

var card_type= "jumpif"
var connection_port_TRUE_bool = false
var connection_port_FALSE_bool = false

#Condition index
# 0 - equal
# 1 - Less Than
# 2 - Greater than
# 3 - Less than or equal to
# 4 - Greater than or equal to
var condition = 0
var spin_value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_slot(1,true,0,Color(Color.WHITE),true,1,Color(Color.GREEN))
	set_slot(2,false,0,Color(Color.WHITE),true,2,Color(Color.RED))


func _on_option_button_item_selected(index):
	condition = index


func _on_spin_box_value_changed(value):
	spin_value = int(value)

func perform_operation():
	MM.emit_signal("set_curr_card","JUMP IF")
	GT.start()
	await GT.timeout
	MM.do_insert_line("Jump If card process is met. Checking connections... [0/2]","normal")
	if connection_port_TRUE_bool:
		GT.start()
		await GT.timeout
		MM.do_insert_line("Jump If THEN connection is established. Checking connections... [1/2]","normal")
		if connection_port_FALSE_bool:
			GT.start()
			await GT.timeout
			MM.do_insert_line("Jump If ELSE connection is established. Checking connections... [2/2]","normal")
			GT.start()
			await GT.timeout
			MM.do_insert_line("All connnections are established. Checking condition...","normal")
			var is_condition_true = false
			match condition:
				0:
					GT.start()
					await GT.timeout
					MM.do_insert_line("Is " + str(main.current_box_value) + " equal to array index " + str(spin_value) + " with the value of " + str(main.ARRAY_VALS[spin_value]) + " ?","normal")
					if main.current_box_value == spin_value:
						is_condition_true = true
				1:
					GT.start()
					await GT.timeout
					MM.do_insert_line("Is " + str(main.current_box_value) + " less than the array index " + str(spin_value) + " with the value of " + str(main.ARRAY_VALS[spin_value]) + " ?","normal")
					if main.current_box_value < spin_value:
						is_condition_true = true
				2:
					GT.start()
					await GT.timeout
					MM.do_insert_line("Is " + str(main.current_box_value) + " greater than array index " + str(spin_value) + " with the value of " + str(main.ARRAY_VALS[spin_value]) + " ?","normal")
					if main.current_box_value > spin_value:
						is_condition_true = true
				3:
					GT.start()
					await GT.timeout
					MM.do_insert_line("Is " + str(main.current_box_value) + " less than or equal to array index " + str(spin_value) + " with the value of " + str(main.ARRAY_VALS[spin_value]) + " ?","normal")
					if main.current_box_value <= spin_value:
						is_condition_true = true
				4:
					GT.start()
					await GT.timeout
					MM.do_insert_line("Is " + str(main.current_box_value) + " greater than or equal to array index " + str(spin_value) + " with the value of " + str(main.ARRAY_VALS[spin_value]) + " ?","normal")
					if main.current_box_value >= spin_value:
						is_condition_true = true
						
			if is_condition_true:
				print("Condition is true")
				GT.start()
				await GT.timeout
				MM.do_insert_line("Condition is true. Proceeding to THEN connection...","normal")
				print("Going to True Condition")
				MM.emit_signal("get_connection_from_if",self.name,0)
			else:
				GT.start()
				await GT.timeout
				MM.do_insert_line("Condition is true. Proceeding to ELSE connection...","normal")
				print("Going to False Condition")
				MM.emit_signal("get_connection_from_if",self.name,1)
		else:
			GT.start()
			await GT.timeout
			MM.do_insert_line("ERROR: ELSE Connection is not connected to any card","error")
			GT.start()
			await GT.timeout
			MM.do_print_error("Connection ELSE is not connected to any card")
	else:
		GT.start()
		await GT.timeout
		MM.do_insert_line("ERROR: THEN Connection is not connected to any card","error")
		GT.start()
		await GT.timeout
		MM.emit_signal("print_error", "Connection THEN is not connected to any card")
