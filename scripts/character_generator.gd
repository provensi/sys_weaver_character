extends Node3D

# Copied from top-level character_generator.gd. See README for details.

@export var body_height: float = 2.0
@export var body_width: float = 1.0
@export var head_size: float = 0.8
@export var arm_length: float = 1.2
@export var leg_length: float = 1.5

var body: MeshInstance3D
var head: MeshInstance3D
var left_arm: MeshInstance3D
var right_arm: MeshInstance3D
var left_leg: MeshInstance3D
var right_leg: MeshInstance3D
var shader_mat: ShaderMaterial

func _ready() -> void:
    var toon_shader := load("res://scripts/toon_shader.gdshader")
    shader_mat = ShaderMaterial.new()
    shader_mat.shader = toon_shader

    body = MeshInstance3D.new()
    body.mesh = BoxMesh.new()
    (body.mesh as BoxMesh).size = Vector3(body_width, body_height, body_width)
    body.material_override = shader_mat
    body.translation = Vector3(0.0, body_height / 2.0, 0.0)
    add_child(body)

    head = MeshInstance3D.new()
    head.mesh = SphereMesh.new()
    (head.mesh as SphereMesh).radius = head_size
    head.material_override = shader_mat
    head.translation = Vector3(0.0, body_height + head_size, 0.0)
    add_child(head)

    left_arm = MeshInstance3D.new()
    left_arm.mesh = BoxMesh.new()
    (left_arm.mesh as BoxMesh).size = Vector3(0.3, arm_length, 0.3)
    left_arm.material_override = shader_mat
    left_arm.translation = Vector3(-(body_width / 2.0 + 0.2), body_height - 0.5, 0.0)
    add_child(left_arm)

    right_arm = left_arm.duplicate()
    right_arm.translation.x = -left_arm.translation.x
    add_child(right_arm)

    left_leg = MeshInstance3D.new()
    left_leg.mesh = BoxMesh.new()
    (left_leg.mesh as BoxMesh).size = Vector3(0.3, leg_length, 0.3)
    left_leg.material_override = shader_mat
    left_leg.translation = Vector3(-0.3, leg_length / 2.0, 0.0)
    add_child(left_leg)

    right_leg = left_leg.duplicate()
    right_leg.translation.x = -left_leg.translation.x
    add_child(right_leg)

func update_character() -> void:
    (body.mesh as BoxMesh).size = Vector3(body_width, body_height, body_width)
    body.translation.y = body_height / 2.0
    (head.mesh as SphereMesh).radius = head_size
    head.translation.y = body_height + head_size
    (left_arm.mesh as BoxMesh).size = Vector3(0.3, arm_length, 0.3)
    left_arm.translation = Vector3(-(body_width / 2.0 + 0.2), body_height - 0.5, 0.0)
    (right_arm.mesh as BoxMesh).size = Vector3(0.3, arm_length, 0.3)
    right_arm.translation = Vector3(-left_arm.translation.x, left_arm.translation.y, 0.0)
    (left_leg.mesh as BoxMesh).size = Vector3(0.3, leg_length, 0.3)
    left_leg.translation = Vector3(-0.3, leg_length / 2.0, 0.0)
    (right_leg.mesh as BoxMesh).size = Vector3(0.3, leg_length, 0.3)
    right_leg.translation = Vector3(-left_leg.translation.x, left_leg.translation.y, 0.0)
