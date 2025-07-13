extends CanvasLayer

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	var _visible = $Controls.visible
	$Controls.visible = not _visible
	$Menu.visible = _visible
	$InventoryGrid.visible = _visible


func _on_menu_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	$Controls.visible = false
	$Menu.visible = true
	$InventoryGrid.visible = true
