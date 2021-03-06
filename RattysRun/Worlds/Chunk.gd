extends Spatial
class_name Chunk


var mesh_instance
var noise
var x
var z
var chunk_size
var should_remove = true
var tree = preload("res://Worlds/Tree.tscn")


func _init(noise, x, z, chunk_size):
	self.noise = noise
	self.x = x
	self.z = z
	self.chunk_size = chunk_size

func _ready():
	generate_water()
	generate_chunk()

	
func generate_chunk():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(chunk_size, chunk_size)
	plane_mesh.subdivide_depth = chunk_size * 0.5
	plane_mesh.subdivide_width = chunk_size * 0.5
	
	plane_mesh.material = preload("res://Worlds/terrain.material")
	
	var surface_tool = SurfaceTool.new()
	var data_tool = MeshDataTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var array_plane = surface_tool.commit()
	var _error = data_tool.create_from_surface(array_plane, 0)
	
	for i in range(data_tool.get_vertex_count()):
		var vertex = data_tool.get_vertex(i)
		vertex.y = noise.get_noise_3d(vertex.x + x, vertex.y, vertex.z + z) * 80
		data_tool.set_vertex(i, vertex)
		if vertex.y >= 6:
			var rand = randi() % 1000
			if rand == 1:
				var TREE = tree.instance()
				TREE.translation = Vector3(vertex.x, vertex.y, vertex.z)
				add_child(TREE)

	for s in range(array_plane.get_surface_count()):
		array_plane.surface_remove(s)

	data_tool.commit_to_surface(array_plane)

	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(array_plane, 0)
	surface_tool.generate_normals()
	
	mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	mesh_instance.create_trimesh_collision()
	mesh_instance.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_ON
	add_child(mesh_instance)

func generate_water():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(chunk_size, chunk_size)
	plane_mesh.material = preload("res://Worlds/water.material")
	mesh_instance = MeshInstance.new()
	mesh_instance.mesh = plane_mesh
	add_child(mesh_instance)
