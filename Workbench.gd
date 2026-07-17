extends Control

@onready var result_label: Label = $ResultLabel
@onready var deficiency_panel: Panel = $DeficiencyPanel
@onready var deficiency_label: Label = $DeficiencyPanel/DeficiencyLabel
@onready var continue_button: Button = $DeficiencyPanel/ContinueButton

func _ready() -> void:
	deficiency_panel.visible = false
	continue_button.visible = false
	result_label.text = "Click TEST SOIL to analyze the sample."

func _on_test_button_pressed() -> void:
	deficiency_label.text = "Analysis complete.\nDeficiency detected:\nHeavy Metal Contamination"
	deficiency_panel.visible = true
	continue_button.visible = true
	result_label.text = "Soil test finished."

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Mixing.tscn")
