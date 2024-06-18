extends Control
var level_scene = preload("res://instantiables/level_scene.tscn")
@onready var grid = $levels/ScrollContainer/grid

@onready var clear_ui = $clear_ui
@onready var import_ui = $import_ui
@onready var code = $import_ui/Panel/code
@onready var import_time = $import_ui/import_time
@onready var progress = $progress
@onready var easy_progress_label = $progress/Panel/Control/VBoxContainer/easy
@onready var medium_progress_label = $progress/Panel/Control/VBoxContainer/medium
@onready var hard_progress_label = $progress/Panel/Control/VBoxContainer/hard
@onready var total_progress_label = $progress/Panel/Control/VBoxContainer/total


var is_loaded = false

func instantiate_levels():
	for i in range(0,LM.level_descs.size()):
		var lv = level_scene.instantiate()
		lv.custom_minimum_size = Vector2(168, 202)
		lv.level_props = LM.level_descs[i]
		
		grid.add_child(lv)
		if lv.level_props.id in SL.completed_levels:
			lv.make_complete()

func get_count(difficulty):
	var count = 0
	
	for level in LM.level_descs:
		if level["difficulty"] == difficulty:
			count += 1
	
	print(count)
	return count
	
func get_done(difficulty):
	var count = 0
	for id in SL.completed_levels:
		for level in LM.level_descs:
			if level["id"] == id:
				if level["difficulty"] == difficulty:
					count += 1
	
	return count

func get_progress_report():
	var total = LM.level_descs.size()
	var easy_count = 0
	var easy_done = 0
	
	var medium_count = 0
	var medium_done = 0
	
	var hard_count = 0
	var hard_done = 0
	
	easy_count = get_count(1)
	medium_count = get_count(2)
	hard_count = get_count(3)
	
	easy_done = get_done(1)
	medium_done = get_done(2)
	hard_done = get_done(3)
	
	
	
	easy_progress_label.text = str(easy_done) + " out of " + str(easy_count) + " EASY levels completed"
	medium_progress_label.text = str(medium_done) + " out of " + str(medium_count) + " MEDIUM levels completed"
	hard_progress_label.text = str(hard_done) + " out of " + str(hard_count) + " HARD levels completed"
	total_progress_label.text = str(SL.completed_levels.size()) + " out of " + str(total) + " TOTAL levels completed"
	
	

func _ready():

	SL.load_game()
	instantiate_levels()
	
	clear_ui.hide()
	import_ui.hide()
	progress.hide()
	
	get_progress_report()
		
		
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Menu/MainMenu.tscn")


func _on_clear_pressed():
	
	clear_ui.show()


func _on_create_pressed():
	#TODO
	pass # Replace with function body.


func _on_close_create_pressed():
	clear_ui.hide()


func _on_yes_create_pressed():
	LM.clear_levels()
	for child in grid.get_children():
		child.queue_free()

	instantiate_levels()
	clear_ui.hide()

func _on_sandbox_pressed():
	SandBoxManager.reset_settings()
	LM.make_level("SANDBOX")


func _on_play_custom_pressed():
	import_ui.show()


func _on_close_import_pressed():
	import_ui.hide()


func _on_instantiate_import_pressed():
	var data = SandBoxManager.utf8_to_json(code.text)
	var panel = $import_ui/Panel
	if data != null:
		if SandBoxManager.import_level(data) == false:
			panel.modulate = Color.DARK_RED
			import_time.start()
	else:
		panel.modulate = Color.DARK_RED
		import_time.start()


func _on_import_time_timeout():
	var panel = $import_ui/Panel
	panel.modulate = Color.WHITE


func _on_check_pressed():
	progress.show()


func _on_close_check_pressed():
	progress.hide()
