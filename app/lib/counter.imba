export default tag Counter < button
	# This is the internal state of the tag. We're not exposing it with `prop`
	# because we want to read the count from the server:
	count = 0
	
	# Mount runs when this tag is first attached to the DOM.
	# https://imba.io/docs/components/lifecycle
	def mount
		# Fetch the count from the server
		try
			const res = await window.fetch('/count')
			const data = await res.json()
			count = data.count
		catch e
			console.error("Couldn't fetch count", e)

	<self> `Count is {count}`
