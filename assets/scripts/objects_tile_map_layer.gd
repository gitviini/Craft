extends TileMapLayer
class_name ObjectsTileMapLayer

@export_category("Variables")
@export var _tile_scenes:Dictionary = {
	0: preload("res://scenes/tree.tscn")
}

func _ready() -> void:
	await get_tree().process_frame
	_tile_for_scene(_tile_scenes)
	
func _tile_for_scene(_scenes:Dictionary) -> void:
	for _tile_pos in get_used_cells():
		var _tile_id = get_cell_source_id(_tile_pos)
		if _tile_scenes.has(_tile_id):
			var _object_scene = _tile_scenes[_tile_id]
			_tile_for_object(_tile_pos, _object_scene)
			
func _tile_for_object(_tile_pos: Vector2i, _object_scene: PackedScene, _parent: Node2D = get_parent()):
	erase_cell(_tile_pos)
	if _object_scene:
		var _object = _object_scene.instantiate()
		_object.global_position = map_to_local(_tile_pos)
		_parent.add_child(_object)
