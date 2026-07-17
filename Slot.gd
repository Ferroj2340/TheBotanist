class_name Slot
extends Panel

var held_item: IngredientItem = null
var held_ingredient_id: String = ""

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return held_item == null \
		and data is Dictionary \
		and data.has("item") \
		and data["item"] is IngredientItem \
		and data.has("ingredient_id")

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var item: IngredientItem = data["item"]
	held_item = item
	held_ingredient_id = str(data["ingredient_id"])
	item.snap_into_slot(self)

func recenter_item(item: IngredientItem) -> void:
	if held_item == item:
		item.reparent(self)
		item.position = (size - item.size) / 2
		item.show()

func clear_slot() -> void:
	if held_item != null:
		held_item._return_home()
	held_item = null
	held_ingredient_id = ""
