######################################################################
# CLASS - Drum
######################################################################
class exports.Drum extends PageComponent
	constructor: (options = {}) ->
		@__constructor = true
		@_options = options.options ? ["Blaine", "Billingsley", "is", "cool"]
# 		@_drumProps = options.drumProps ? null
		@_drumHeight = 32 * 6
		@_startIndex = options.startIndex ? 0
		@_textAlign = options.textAlign ? "center"
		@_value = null
		# Defaults
		super _.defaults options, 
			width: Screen.width, height: @_drumHeight
			y: Align.bottom
			scrollHorizontal: false
			backgroundColor: "white"
			velocityThreshold: .01
			originY: 0
			contentInset:
				top: @_drumHeight / 2 - 24
				bottom: @_drumHeight
			clip: true
		
		# Flip the boolean after the constructor is done.
		@__constructor = false
		
		# Child layers
		@scrimTop = new Layer
			width: @width
			height: (@.height - 36) / 2
			parent: @
			name: "."
			gradient: 
				start: "rgba(255,255,255,.6)"
				end: "rgba(255,255,255,1)"
			style: 
				"border-bottom" : "1px solid #dbdbdb"
		@scrimBottom = new Layer
			width: @width
			height: (@.height - 36) / 2
			parent: @
			name: "."
			y: Align.bottom
			gradient: 
				end: "rgba(255,255,255,.6)"
				start: "rgba(255,255,255,1)"
			style: 
				"border-top" : "1px solid #dbdbdb"
				

		@setOptions(@_options)
		if @_startIndex > 0 then @.snapToPage(@.content.children[@_startIndex], false)
		@_value = @.currentPage.text

		@content.name = "."
		@.on "change:currentPage", -> @_value = @.currentPage.text
	# Functions
	setOptions: (optionArray) ->
		for opt, o in optionArray
			item = new TextLayer _.defaults @_drumProps,
				fontSize: 20
				height: 36
				textAlign: @_textAlign
				width: @width
				text: opt
				color: "#484848"
				name: '.'
				parent: @.content
				y: (36) * o
				padding: { horizontal: 16}
			@.updateContent()

	resetOptions: (optionArray) ->
		child.destroy() for child in @.content.children
		@setOptions(optionArray)
	
	# Custom definitions
	@define "options",
		get: -> return @_options
		set: (value) -> 
			return if @__constructor
			@_options = value
			@resetOptions(@_options)
	@define "value",
		get: -> return @_value
		set: (value) ->
			return if @__constructor
			@_value = value




#####################################################################
# CLASS - Picker
######################################################################
class exports.Picker extends Layer
	constructor: (options = {}) ->
		@__constructor = true
		@_drums = options.drums ? null
		@_drum = options.drum ? null
		@_xVal = 0
		# Defaults
		super _.defaults options, 
			width: Screen.width, height: 216
			y: Align.bottom
			backgroundColor: "white"
			clip: true
			style:
				"border-top" : "1px solid #ccc"
		
		# Flip the boolean after the constructor is done.
		@__constructor = false
		@.states.hidden =
			y: Screen.height
		@.states.animationOptions = time: .3, curve: Spring(damping:.8)
		# Child layers
		@toolbar = new TextLayer
			width: @width
			height: 44
			parent: @
			backgroundColor: "#FAFAF8"
			textAlign: "right"
			text: "Done"
			fontSize: 15
			lineHeight: 3
			fontWeight: "bold"
			padding: {right: 16}
			color: "#007AFF"
			style:
				"border-bottom" : "1px solid #dbdbdb"
		if @_drums is null then @_drums = [{options: @_drum}]

		for drum, d in @_drums
			dr = @["drum#{d}"] = new exports.Drum
				name: "drum#{d}"
				height: @height - 44
				parent: @
				startIndex: drum.startIndex ? 0
				width: drum.width ? @width
				options: drum.options ? ["One","Two","Three","Four"]
				textAlign: drum.textAlign ? "center"
				x: drum.x ? @_xVal
			@_xVal = dr.maxX
