extends GraphEdit

@onready var main = get_parent().get_parent()

var inp = preload("res://instantiables/GraphNodes/InputGraphNode.tscn")
var out = preload("res://instantiables/GraphNodes/OutputGraphNode.tscn")
var art = preload("res://instantiables/GraphNodes/ArithmeticNode.tscn")
var jump = preload("res://instantiables/GraphNodes/JumpGraphNode.tscn")
var jumpif = preload("res://instantiables/GraphNodes/JumpIfGraphNode.tscn")
var store = preload("res://instantiables/GraphNodes/StoreToNode.tscn")
var copy = preload("res://instantiables/GraphNodes/CopyFromNode.tscn")

@onready var inp_button = $"../Buttons/Panel/BoxContainer/ButtonVert/inp_button"
@onready var art__button = $"../Buttons/Panel/BoxContainer/ButtonVert/art__button"
@onready var jump_button = $"../Buttons/Panel/BoxContainer/ButtonVert/jump_button"
@onready var jumpif_button = $"../Buttons/Panel/BoxContainer/ButtonVert/jumpif_button"
@onready var out__button = $"../Buttons/Panel/BoxContainer/ButtonVert/out__button"
@onready var store_button = $"../Buttons/Panel/BoxContainer/ButtonVert/store_button"
@onready var copy_button = $"../Buttons/Panel/BoxContainer/ButtonVert/copy_button"
@onready var card_spawn = $"../card_spawn"


@onready var inp_label = $"../Buttons/Panel/BoxContainer/CounterVert/inp_panel/inp_label"
@onready var out_label = $"../Buttons/Panel/BoxContainer/CounterVert/out_panel/out_label"
@onready var art_label = $"../Buttons/Panel/BoxContainer/CounterVert/art_panel/art_label"
@onready var jump_label = $"../Buttons/Panel/BoxContainer/CounterVert/jump_panel/jump_label"
@onready var jumpif_label = $"../Buttons/Panel/BoxContainer/CounterVert/jumpif_panel/jumpif_label"
@onready var store_label = $"../Buttons/Panel/BoxContainer/CounterVert/store_panel/store_label"
@onready var copy_label = $"../Buttons/Panel/BoxContainer/CounterVert/copy_panel/copy_label"

#Sounds
@onready var connect_card = $"../sounds/connect_card"
@onready var delete_sound_base = $"../sounds/DeleteSoundBase"
@onready var spawn_card = $"../sounds/spawn_card"
@onready var disconnect_card = $"../sounds/disconnect_card"


func _ready():
	add_valid_connection_type(1,0)
	add_valid_connection_type(2,0)
	MM.level_instantiated.connect(set_labels)
	MM.closed_card.connect(close_card)
	
func close_card(from):
	match from.card_type:
		"inp":
			main.BUTTONS.inp.count += 1
		"out":
			main.BUTTONS.out.count += 1
		"art":
			main.BUTTONS.art.count += 1
		"jump":
			main.BUTTONS.jump.count += 1
		"jumpif":
			main.BUTTONS.jumpif.count += 1
		"store":
			main.BUTTONS.store.count += 1
		"copy":
			main.BUTTONS.copy.count += 1
	
	set_labels()
	delete_sound_base.play()
	

func set_labels():
	inp_label.text = str(main.BUTTONS.inp.count)
	out_label.text = str(main.BUTTONS.out.count)
	art_label.text = str(main.BUTTONS.art.count)
	jump_label.text = str(main.BUTTONS.jump.count)
	jumpif_label.text = str(main.BUTTONS.jumpif.count)
	store_label.text = str(main.BUTTONS.store.count)
	copy_label.text = str(main.BUTTONS.copy.count)
	
	if main.BUTTONS.inp.count <= 0:
		inp_button.disabled = true
	else:
		inp_button.disabled = false
		
		
	if main.BUTTONS.out.count <= 0:
		out__button.disabled = true
	else:
		out__button.disabled = false
		
		
	if main.BUTTONS.art.count <= 0:
		art__button.disabled = true
	else:
		art__button.disabled = false
		
		
	if main.BUTTONS.jump.count <= 0:
		jump_button.disabled = true
	else:
		jump_button.disabled = false
		
		
	if main.BUTTONS.jumpif.count <= 0:
		jumpif_button.disabled = true
	else:
		jumpif_button.disabled = false
		
	if main.BUTTONS.store.count <= 0:
		store_button.disabled = true
	else:
		store_button.disabled = false
	
	if main.BUTTONS.copy.count <= 0:
		copy_button.disabled = true
	else:
		copy_button.disabled = false
		

func summon(type: String):
	var temp
	match type:
		"inp":
			temp = inp.instantiate()
			main.BUTTONS.inp.count -= 1
		"out":
			temp = out.instantiate()
			main.BUTTONS.out.count -= 1
			
		"art":
			temp = art.instantiate()
			main.BUTTONS.art.count -= 1
			
		"jump":
			temp = jump.instantiate()
			main.BUTTONS.jump.count -= 1
			
		"jumpif":
			temp = jumpif.instantiate()
			main.BUTTONS.jumpif.count -= 1
			
		"store":
			temp = store.instantiate()
			main.BUTTONS.store.count -= 1
			
		"copy":
			temp = copy.instantiate()
			main.BUTTONS.copy.count -= 1
	
	temp.position_offset = card_spawn.position
	
	for node in get_children():
		node.selected = false
		
	temp.selected = true
	
	
	add_child(temp)
	set_labels()
	spawn_card.play()

func _on_inp_button_pressed():
	summon("inp")

func _on_connection_request(from_node, from_port, to_node, to_port):
	var allowed = false
	var from_node_instance = get_node(""+from_node)
	var to_node_instance = get_node(""+to_node)
	
	#should not connect by itself	
	if from_node == to_node:
		return
	
	
	match from_node_instance.card_type:
		"jump":
			#Connect regardless if there is an initial connection
			for node in get_connection_list():
			# Should update line if it is already connected to an input
				if node.from == from_node:
					from_node_instance.connection_count += 1
			
			if from_node_instance.connection_count > 0:
				return
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
			allowed = true
			
		"jumpif":
			for node in get_connection_list():
				#A TRUE port is already connected to something
				if node.from_port==0 and node.from == from_node:
					break
#					from_node_instance.connection_port_TRUE_bool = true
				#A FALSE port is already connected to something
				elif node.from_port==1 and node.from == from_node:
					break
#					from_node_instance.connection_port_FALSE_bool = true
					
			
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
			
			if not from_node_instance.connection_port_TRUE_bool:
				allowed = true
				from_node_instance.connection_port_TRUE_bool = true
				
			elif not from_node_instance.connection_port_FALSE_bool:
				allowed = true
				from_node_instance.connection_port_FALSE_bool = true
			
			print(allowed)
			
			
		"start":
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					from_node_instance.connection_count +=1
					
			if from_node_instance.connection_count == 0:
				allowed = true
				
			#Should not connect to other jumps
			if to_node_instance.card_type == "jump" or to_node_instance.card_type == "jumpif":
				return
				
		_: #default
			for node in get_connection_list():
				#Should only accept one input
				if node.to == to_node and node.to_port == to_port:
					return
					
				if node.from == from_node:
					from_node_instance.connection_count +=1
					
			if from_node_instance.connection_count == 0:
				allowed = true
		
	
	if allowed:
		connect_node(from_node,from_port,to_node,to_port)
		connect_card.play()
		
	
	print(get_connection_list())
	
	


func _on_out__button_pressed():
	summon("out")


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	print(from_node, from_port, to_node, to_port)
	var from_node_instance = get_node(""+from_node)
	
	if from_node_instance.card_type == "jumpif" and from_port == 0:
		from_node_instance.connection_port_TRUE_bool = false
	elif from_node_instance.card_type == "jumpif" and from_port == 1:
		from_node_instance.connection_port_FALSE_bool = false
	else:
		from_node_instance.connection_count = 0
	
	disconnect_node(from_node,from_port,to_node,to_port)
	disconnect_card.play()


func _on_jump_button_pressed():
	summon("jump")


func _on_jumpif_button_pressed():
	summon("jumpif")


func _on_art__button_pressed():
	summon("art")


func _on_store_button_pressed():
	summon("store")


func _on_copy_button_pressed():
	summon("copy")
