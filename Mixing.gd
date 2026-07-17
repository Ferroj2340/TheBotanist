extends Control

@onready var result_panel: Panel = $ResultPanel
@onready var result_label: Label = $ResultPanel/ResultLabel

@onready var slot_1: Slot = $MixingPanel/Slot1
@onready var slot_2: Slot = $MixingPanel/Slot2

@onready var compost_item: Button = $CompostItem
@onready var chelating_item: Button = $ChelatingItem
@onready var biochar_item: Button = $BiocharItem

var ingredient_items: Array[Button] = []

func _ready() -> void:
	ingredient_items = [compost_item, chelating_item, biochar_item]
	result_label.text = "Drag 2 ingredients into the slots, then press MIX."
	_update_result_color(Color("#f2ebdd"))

func _on_mix_button_pressed() -> void:
	var a: String = slot_1.held_ingredient_id
	var b: String = slot_2.held_ingredient_id

	if a == "" or b == "":
		result_label.text = "Place 2 ingredients first."
		_update_result_color(Color("#f2ebdd"))
		return

	var correct: bool = (
		(a == "chelating_agent" and b == "biochar")
		or (a == "biochar" and b == "chelating_agent")
	)

	if correct:
		result_label.text = "Correct mix.\nSoil treatment created successfully."
		_update_result_color(Color("#90c98a"))
	else:
		result_label.text = "Incorrect mix.\nTry again."
		_update_result_color(Color("#d96b6b"))
		_reset_all_ingredients()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Workbench.tscn")

func _reset_all_ingredients() -> void:
	for item in ingredient_items:
		if item.has_method("reset_home"):
			item.reset_home()

	slot_1.clear_slot()
	slot_2.clear_slot()

func _update_result_color(color: Color) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.border_color = Color("#4a3a2a")
	result_panel.add_theme_stylebox_override("panel", style)
