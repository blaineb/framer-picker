# framer-picker
iOS-style wheel picker for Framer



## Usage
Drop it into your prototype and put this in the top line:
```
{Picker} = require 'picker'
```


## Simple example
Pass an array to `drum` for a simple, one-drum picker
```picker = new Picker
    drum: ["Option A","Option B","Option C","Option D"] 
```
    

## Multi-drums
1. Create an array of objects make your drum.
```
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
```

2. Initialize the picker.
```
multiPicker = new Picker
    drums: drumContent
```
    
You can use the "hidden" state to switch between it being visible or not
`multiPicker.stateSwitch "hidden"`

...And bring it back with the default state.
`multiPicker.animate "default"`

Each drum is accessed with dot syntax, like `multiPicker.drum0`, `multiPicker.drum1`, etc...

You can access the value like so
```
multiPicker.drum0.on "change:currentPage", ->
    print @.value
```

Access the toolbar with `multiPicker.toolbar`. To close the picker when tapping "Done":
```
multiPicker.toolbar.onTap ->
	timePicker.stateSwitch "hidden"
```
