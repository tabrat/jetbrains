pack = Packages.register
	name: 'intellij'
	description: 'IntelliJ integration'
	application: 'com.jetbrains.intellij'

pack.settings
	identifiers: require('./identifiers')
	surroundWith: require('./surroundwith')
	siblings: 
		class: "class"
		file: "file"
		package: "package"

pack.implement
	# implementation of standard editor commands
	'editor:toggle-comments': ->
		@key '/', 'command'
	'editor:expand-selection-to-scope': ->
   		@key 'up', 'option'
	'editor:expand-selection-to-indentation': ->
	    @key '[', 'command option'
	    @delay 50
	    @key ']', 'command option shift'
	'editor:move-to-line-number': (input) ->
	    if input
	    	@key 'l', 'command'
	    	@string input
	    	@key 'return'
	    else
	    	@key 'l', 'command'
	'editor:select-line-number': (input) ->
		if input
			@do 'editor:move-to-line-number-and-way-left', input
			@key 'right', 'command shift'
	'editor:insert-code-template': (args) ->
		# TODO
	'editor:select-line-number-range': (input) ->
		@selectRange input
	'editor:extend-selection-to-line-number': (input) ->
		@selectToLineNumber input

	# implementation of miscellaneous commands
	'object:backward': ->
		@key 'left', 'command option'
	'object:forward': ->
		@key 'right', 'command option'
	'object:duplicate': ->
    	@key 'd', 'command'
	'mouse-combo:insert-hovered': ->
		@insertHovered()
	'delete:lines': (input) ->
		# only support single line input for now
		if input
			@do 'editor:move-to-line-number', input.first
			@delay 50
		@key 'delete', 'command'
	'delete:way-left': ->
		@key 'left', 'command shift'
		@key 'delete'
	'delete:way-right': ->
		@key 'right', 'command shift'
		@key 'delete'



pack.commands
	"basic-code-completion":
		spoken: "comply"
		description: "Basic code completion (filters the list of methods and variables by expected type)"
		action: ->
			@key 'Space', 'control'
	"parameter-info": 
		spoken: "param info"
		description: "Shows parameter info at caret"
		action: ->
			@click()
			@delay 25
			@key 'p', 'command'
	"quick-documentation-lookup":
		spoken: "documentation"
		description: "Quick documentation lookup"
		action: ->
			@key 'j', 'control'
	"override-methods":
		spoken: "overrider"
		description: "Override methods"
		action: ->
			@key 'o', 'control'
	"implement-methods":
		spoken: "implementer"
		description: "Implement methods"
		action: ->
			@key 'i', 'control'
	"import-class":
		spoken: "import class"
		description: "Import class"
		misspellings: ["important class", "importer class"]
		action:	->
			@key 'return', 'option'
			@delay 25
			@enter()
	"decrease-code-blocks-selection":
		spoken: "crackle"
		description: "Decrease current selection to previous state"
		repeatable: true
		action: ->
			@key 'down', 'option'
	"intention-actions":
		spoken: "quickfix"
		description: "Show intention actions and quick fixes"
		action: ->
			@key 'Return', 'option'
	"reformat-code":
		spoken: "reformat"
		description: "Reformat code"
		action: ->
			@key 'l', 'command option'
	"optimize-imports":
		spoken: "optimizer"
		description: "Optimize imports"
		action: ->
			@key 'o', 'control option'
	"auto-indent":
		spoken: "indent"
		description: "Auto indent selected line(s)"
		misspellings: ["indents"]
		action: ->
			@key 'i', 'control option'
	"smart-line-join":
		spoken: "line join"
		description: "Smart line join"
		misspellings: ["length join", "why join"]
		action: ->
			@key 'j', 'control shift'
	"toggle-case":
		spoken: "caser"
		description: "toggle case for word at caret or selected block"
		misspellings: ["kaser", "cancer"]
		action: ->
			@key 'u', 'command shift'
	"recent-files":
		spoken: "recent"
		description: "Recent files popup. With argument, will go n back in history"
		grammarType: "oneArgument"
		action: (input) ->
			@key 'e', 'command'
			if input
				@delay 25
				@do 'combos:choose-item-below', parseInt(input)
	"navigate-last-edit":
		spoken: "last edit"
		description: "Navigate to last edit location"
		action: ->
			@key 'delete', 'command shift'
	"select-current-file-in-project-view":
		spoken: "view file"
		description: "Select current file or symbol in project view"
		misspellings: ["review file", "you file"]
		action: ->
			@key 'F1', 'option'
			@delay 25
			@enter()
	"go-to-class":
		spoken: "go class"
		description: "Search for class"
		action: ->
			@key 'o', 'command'
	"go-to-file":
		spoken: "go file"
		description: "Search for file"
		action: ->
			@key 'o', 'command shift'
	"go-to-symbol":
		spoken: "go symbol"
		description: "Search for symbol"
		action: ->
			@key 'o', 'command option'
	"go-to-declaration":
		spoken: "go deckle"
		description: "Go to declaration"
		misspellings: ["go jekyll", "go deco"]
		action: ->
			@key 'b', 'command'
	"go-to-implementation":
		spoken: "go implement"
		description: "Go to implementation(s)"
		action: ->
			@key 'b', 'command'
			# todo: add input
	"go-to-type-declaration":
		spoken: "go type"
		description: "Go to type declaration"
		action: ->
			@key 'b', 'command shift'
	"go-to-super":
		spoken: "go super"
		description: "Go to super-method/class"
		action: ->
			@key 'u', 'command'
	"go-previous-method":
		spoken: "preev method"
		description: "Go to previous method"
		misspellings: ["reprieve method"]
		repeatable: true
		action: ->
			@key 'up', 'control'
	"go-next-method":
		spoken: "neck method"
		description: "Go to next method"
		repeatable: true
		action: ->
			@key 'down', 'control'
	"move-file":
		spoken: "move file"
		description: "Move file"
		action: ->
			@key 'F6'
	"rename-file":
		spoken: "refactor"
		description: "Rename file"
		action: ->
			@key 'F6', 'shift'
	"inline":
		spoken: "inliner"
		description: "Inline code"
		action: ->
			@key 'n', 'command option'
	"extract-method":
		spoken: "extract method"
		description: "Extract method"
		action: ->
			@key 'm', 'command option'
	"extract-variable":
		spoken: "extract variable"
		description: "Extract variable"
		action: ->
			@key 'v', 'command option'
	"extract-field":
		spoken: "extract field"
		description: "Extract field"
		action: ->
			@key 'f', 'command option'
	"extract-constant":
		spoken: "extract constant"
		description: "Extract constant"
		action: ->
			@key 'c', 'command option'
	"insert-hovered-line":
		spoken: "pinge"
		description: "Grabs the line at cursor (or argument) and inserts it at the original position"
		misspellings: ['pinch']
		action: (input) ->
			@duplicateLineToCurrentPosition input

# Custom grammar commands
pack.commands
	"generate-code":
		spoken: "generate"
		grammarType: 'custom'
		rule: '<spoken> (identifier)'
		description: "Generates code (constructors, getters, setters, getters and setters, hashcode, tostring)"
		variables:
			identifier: -> pack.settings().identifiers
		action: ({identifier}) ->
			@generateCode identifier
	"new-sibling":
		spoken: "sibling"
		grammarType: 'custom'
		rule: '<spoken> (sibling)'
		description: "Creates a new sibling (class, files, directory) in the same structure directory"
		requires: [
			'jetbrains:select-current-file-in-project-view'
		]
		variables:
			sibling: -> pack.settings().siblings
		action: ({sibling}) ->
			@do 'jetbrains:select-current-file-in-project-view'
			@delay 450
			@generateCode sibling
	"surround-with":
		spoken: "surrounder"
		grammarType: "custom"
		rule: "<spoken> (code)"
		description: "Surround with... (if..else, try..catch, for)"
		misspellings: ["surround her"]
		variables:
			code: -> pack.settings().surroundWith
		action: ({code}) ->
			if selected = @getSelectedText()
				@surroundWith code


pack.actions
	generateCode: (input) ->
		@key 'n', 'command'
		if input
			@delay 25
			@string(input)
			@enter()
	surroundWith: (input) ->
		@key 't', 'command option'
		if input
			@string input
			@enter()
	selectToLineNumber: (input) ->
		if input
			clipboard = @getClipboard()
			@key 'l', 'command'
			@delay 100
			@copy()
			@key 'escape'
			copied = _.split @getClipboard(), ':'
			current = parseInt(copied[0])
			target = parseInt(input)
			vert = 'right'
			horiz = 'down'
			if current < target
				lower = current
				higher = target
				vert = 'right'
				horiz = 'down'
			else
				lower = target
				higher = current
				vert = 'left'
				horiz = 'up'
			while lower < higher
				@key horiz, 'shift'
				lower++
			@key vert, 'command shift'
			@setClipboard(clipboard)
	selectRange: (input) ->
		if input
			number = input.trim()
			length = Math.floor(number.length / 2)
			first = number.substr(0, length)
			last = number.substr(length, length + 1)
			first = parseInt(first)
			last = parseInt(last)
			if last < first 
				temp = last
				last = first
				first = temp
			@do 'editor:move-to-line-number-and-way-left', first
			@delay 25
			while first < last
				@key 'down', 'shift'
				first++
			@key 'right', 'command shift'
	insertHovered: ->
		clipboard = @getClipboard()
		@key 'l', 'command'
		@delay 100
		@copy()
		@delay 75
		@key 'escape'
		@delay 25
		origin = @getClipboard()
		@delay 50
		@do 'mouse-combo:double-click-copy'
		@delay 300
		@do 'editor:move-to-line-number', origin
		@delay 300
		@string @getClipboard()
		@delay 25
		@setClipboard(clipboard)
	duplicateLineToCurrentPosition: (input) ->
		clipboard = @getClipboard()
		@key 'l', 'command'
		@delay 100
		@copy()
		@delay 75
		@key 'escape'
		@delay 25
		copied = _.split @getClipboard(), ':'
		origin = parseInt(copied[0])
		@delay 50
		if input
			@do 'editor:move-to-line-number', input
			@delay 50
			@do 'mouse-combo:select-line-copy'
		else
			@do 'mouse-combo:select-hovered-line-copy'
		@delay 200
		@do 'editor:move-to-line-number', origin
		@delay 300
		@string @getClipboard()
		@delay 25
		@setClipboard(clipboard)