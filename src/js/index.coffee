# Menu button component
Vue.component "menu-btn",
	template: "
		<button class='menu-btn'>
			<slot></slot>
		</button>
	"

# Initialize Vue
app = new Vue
	el: "#app"

# Get the background dominant color
getDominantColor = (imgEl) ->
	# only visit every 5 pixels
	blockSize = 5

	# fallback for non-supporting envs
	defaultRGB = r: 0, g: 0, b: 0

	canvas = $("<canvas>")[0]
	context = canvas.getContext && canvas.getContext "2d"
	i = -4
	rgb = r: 0, g: 0, b: 0
	count = 0

	# return the default rgb if the browser don't support <canvas>
	return defaultRGB if !context

	height = canvas.height = imgEl.naturalHeight || imgEl.offsetHeight || imgEl.height
	width = canvas.width = imgEl.naturalWidth || imgEl.offsetWidth || imgEl.width

	context.drawImage imgEl, 0, 0

	try
		data = context.getImageData 0, 0, width, height
	catch e
		# security error, img on diff domain
		return defaultRGB

	length = data.data.length

	while (i += blockSize * 4) < length
		count++
		rgb.r += data.data[i]
		rgb.g += data.data[i+1]
		rgb.b += data.data[i+2]

	# ~~ used to floor values
	rgb.r = ~~ rgb.r / count
	rgb.g = ~~ rgb.g / count
	rgb.b = ~~ rgb.b / count

	return rgb

dominantColor = getDominantColor $(".background-color")[0]
# Unfortunately, uglifyjs don't support ES6 syntax, so, instead of using template string, the concatenation must be made using "+"
$(".menu-btn").css "background-color", "rgb(" + dominantColor.r + "," + dominantColor.g + "," + dominantColor.b + ")"

# Executes whenever the document is ready
$ ->
	# Set the buttons color accordingly to the background dominant color