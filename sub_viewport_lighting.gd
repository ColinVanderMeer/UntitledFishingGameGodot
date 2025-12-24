extends SubViewport

@export var tv_light: Light3D  # Drag your Light3D here in the Inspector
@export var lerp_speed: float = 5.0 # How fast the light color changes

func _process(delta):
	# 1. Get the texture from the viewport
	var tex = get_texture()
	
	# 2. Get the image data
	var img = tex.get_image()
	
	# 3. Shrink the image to 1x1 pixel. 
	# This automatically averages all colors.
	img.resize(1, 1, Image.INTERPOLATE_LANCZOS)
	
	# 4. Grab the color of that single pixel
	var avg_color = img.get_pixel(0, 0)
	
	# 5. Apply it to the light (with a smooth transition)
	# We use lerp so the light "fades" between colors instead of flickering harshly
	tv_light.light_color = avg_color
