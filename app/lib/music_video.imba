export tag MusicVideo
	video = "pkGvRvyEItM"
	playlist = "PLoYeF62lpHeyw9s2nXXndZgROzNlVQojH"

	css iframe
		o:0.9 bd:none m:0 p:0
		h:100%
		w:100%
	
	css .focused
		o: 0.1

	<self[bg:black d:flex ai:center jac:center m:0 p:0]>
		<iframe .focused=data
			src=`https://www.youtube.com/embed/{video}?autoplay=1&loop=1&autohide=0&mute=1&controls=1&listType=playlist&list={playlist}`
			title="Akaihaato - REDHEART 1st original song"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			allowFullscreen>