openModal = (modal) ->
	modal = "##{modal}-modal"
	$(modal).css("display", "flex").addClass "fadeIn"
	$(modal).children(".modal-content").addClass("slideInDown").one "animationend", ->
		$(this).removeClass "slideInDown"

closeModal = (closeBtn) ->
	modal = $(closeBtn).closest ".modal"
	$(modal).addClass("fadeOut").on "animationend", ->
		$(this).removeClass "fadeOut"
	$(modal).children(".modal-content").addClass("slideOutUp").one "animationend", ->
		$(this).removeClass "slideOutUp"
		$(modal).hide()

$(document).on "click", "#about-icon", () -> openModal "about"
$(document).on "click", "#settings-icon", () -> openModal "settings"
$(document).on "click", ".close-btn", (e) -> closeModal e.target
$(document).on "click", ".modal", (e) ->
	if (e.target != this)
		return false
	else
		closeModal e.target

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

# Get the color brightness
getColorBrightness = (rgb) ->
	o = Math.round(((parseInt(rgb[0]) * 299) +
					(parseInt(rgb[1]) * 587) +
					(parseInt(rgb[2]) * 114)) / 1000);
	brightnessOutput = if (o > 125) then "black" else "white"
	return brightnessOutput

dominantColor = getDominantColor $(".background-color")[0]
brightnessOutput = getColorBrightness [dominantColor.r, dominantColor.g, dominantColor.b]

# Formats the dominant color to the css rgb default
dominantColor = "rgb(#{dominantColor.r}, #{dominantColor.g}, #{dominantColor.b})"

$(".action-btn, .modal-content").css(
	"background-color": dominantColor,
	"border-color": brightnessOutput,
	"color": brightnessOutput
)