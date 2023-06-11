export tag FocusToggle
	data = false

	get state
		if data
			"on"
		else
			"off"
		
	def mount
		data = JSON.parse window.localStorage.getItem("focus") or "false"
	
	def toggle
		data = !data
		window.localStorage.setItem "focus", JSON.stringify(data)
	
	css button
		bg:black/90
		bd:clear
		fs:1em
		c:warm6
		cursor@hover:pointer
		td@hover:underline
	
	css .on
		c:green3

	<self>
		<button .on=data @click=toggle> "Focus Mode"
