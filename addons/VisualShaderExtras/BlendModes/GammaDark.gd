@tool
extends VisualShaderNodeCustom
class_name VisualShaderNodeGammaDark

func _get_name():
	return "BlendGammaDark"

func _init() -> void:
	set_input_port_default_value(2, 0.5)

func _get_category():
	return "VisualShaderExtras/BlendModes"

func _get_description():
	return "Gamma Dark Blending Mode"

func _get_return_icon_type():
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_input_port_count():
	return 3

func _get_input_port_name(port):
	match port:
		0:
			return "top layer"
		1:
			return "bottom layer"
		2:
			return "opacity"

func _get_input_port_type(port):
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

func _get_output_port_count():
	return 1

func _get_output_port_name(port: int) -> String:
	return "output"

func _get_output_port_type(port):
	return VisualShaderNode.PORT_TYPE_VECTOR_3D

func _get_global_code(mode):
	return """
		float blend_gamma_dark_f(float c1, float c2)
		{
			return pow(c2, (1.0 / c1));
		}
		
		vec3 blend_gamma_dark(vec3 c1, vec3 c2, float opacity)
		{
			return opacity*vec3(blend_gamma_dark_f(c1.x, c2.x), blend_gamma_dark_f(c1.y, c2.y), blend_gamma_dark_f(c1.z, c2.z)) + (1.0-opacity)*c2;
		}
	"""

func _get_code(input_vars, output_vars, mode, type):
	
	return "%s.rgb = blend_gamma_dark(%s.rgb, %s.rgb, %s);" % [output_vars[0], input_vars[0], input_vars[1], input_vars[2]]
