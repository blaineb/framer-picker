################################################################################
# Picker Module v0.1
# Blaine Billingsley
# Nov 2017
################################################################################

# Module
{Picker} = require 'picker'

# Simple example
picker = new Picker
	drum: ["Option A","Option B","Option C","Option D"] 
	

# Multi-drum example

# 1. Create an array of objects make your drum.
drumContent = [
	{
		options: ["Option A","Option B","Option C","Option D"] # Array of options.
		width: Screen.width / 2 # Specificy a width.  You'll need to do this.
		textAlign: "right" # Optionally, change the alignment.
	}, 
	{
		options: ["Z", "Y", "X", "W", "V", "U","T"]
		startIndex: 3
		width: Screen.width / 2
		textAlign: "left"
	}
]

# 2. Initialize the picker.
multiPicker = new Picker
	drums: drumContent
	
# You can use the "hidden" state
# multiPicker.stateSwitch "hidden"

# And bring it back with the default state.
# multiPicker.animate "default"

# You can access the value like so
# multiPicker.drum0.on "change:currentPage", ->
# 	print @.value