class_name IngredientItem
extends Button

var ingredient_id: String = "compost"

var home_parent: Control
var home_position: Vector2
var home_size: Vector2
var current_slot: Slot = null

func _ready() -> void:
	home_parent = get_parent() as Control
	home_position = position
	home_size = size

	match name:
		"CompostItem":
			ingredient_id = "compost"
		"ChelatingItem":
			ingredient_id = "chelating_agent"
		"BiocharItem":
			ingredient_id = "biochar"

func _get_drag_data(_at_position: Vector2) -> Variant:
	hide()

	var preview := Button.new()
	preview.text = text
	preview.size = size
	set_drag_preview(preview)

	return {
		"item": self,
		"ingredient_id": ingredient_id
	}

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END:
		if is_drag_successful():
			show()
		else:
			if current_slot != null:
				current_slot.recenter_item(self)
			else:
				_return_home()

func _return_home() -> void:
	current_slot = null
	if get_parent() != home_parent:
		reparent(home_parent)
	position = home_position
	size = home_size
	show()

func snap_into_slot(slot: Slot) -> void:
	current_slot = slot
	if get_parent() != slot:
		reparent(slot)
	position = (slot.size - size) / 2
	show()
