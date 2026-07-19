extends Control

@onready var soil_profile_label: Label = $TerminalPanel/SoilProfileLabel
@onready var result_label: Label = $TerminalPanel/ResultLabel
@onready var continue_button: Button = $TerminalPanel/ContinueButton

@onready var beans_button: Button = $TerminalPanel/BeansButton
@onready var carrot_button: Button = $TerminalPanel/CarrotButton
@onready var tomato_button: Button = $TerminalPanel/TomatoButton

var selected_plant: String = ""
var selected_button: Button = null

# Temporary values until the soil testing is connected.
const CURRENT_SOIL_PROFILE := "Clay Soil"
const CORRECT_PLANT := "Beans"

func _ready() -> void:
	soil_profile_label.text = "Current Soil Profile\n\n%s" % CURRENT_SOIL_PROFILE
	result_label.text = "Select a plant, then press CHECK."
	continue_button.visible = false

func _select_plant(button: Button, plant_name: String) -> void:
	_clear_selection()

	selected_button = button
	selected_plant = plant_name

	# Highlight selected button
	selected_button.modulate = Color("#4CAF50")

	result_label.text = "Selected: %s" % plant_name

func _clear_selection() -> void:
	if selected_button != null:
		selected_button.modulate = Color.WHITE

	selected_button = null

func _on_beans_button_pressed() -> void:
	_select_plant(beans_button, "Beans")

func _on_carrot_button_pressed() -> void:
	_select_plant(carrot_button, "Carrot")

func _on_tomato_button_pressed() -> void:
	_select_plant(tomato_button, "Tomato")

func _on_check_button_pressed() -> void:
	if selected_plant == "":
		result_label.text = "Select a plant first."
		return

	if selected_plant == CORRECT_PLANT:
		result_label.text = "✓ Correct! Beans are compatible with Clay Soil."
		continue_button.visible = true

		if selected_button != null:
			selected_button.modulate = Color("#66BB6A")

	else:
		result_label.text = "✗ Incorrect. That plant is not compatible."

		if selected_button != null:
			selected_button.modulate = Color("#D9534F")

		await get_tree().create_timer(0.8).timeout

		_clear_selection()
		selected_plant = ""
		result_label.text = "Select a plant, then press CHECK."

func _on_continue_button_pressed() -> void:
	print("Continue to planting...")
