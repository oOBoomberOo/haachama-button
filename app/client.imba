import { FocusToggle } from './lib/focus_toggle'
import { MusicVideo } from './lib/music_video'
import './assets/app.css'
import './lib/music_video'
import Counter from './lib/counter'

tag App
	focused = false

	css
		h:100%
		d:flex
		fld:column
		--primary:red5
		--text:warm0
		c: var(--text)
	
	css footer
		bg:black
		d:grid
		c:var(--text)
		p:5px 15px
		gtc:1fr 1fr 1fr
		gtr:auto
		ai:center
		ac:center
	css footer a
		c:var(--primary)
	
	css .counter
		pos:absolute
		t:0
		l:0
		b:0
		r:0
		d:flex
		flg:1
		ai:center
		jac:center

	<self>
		<MusicVideo[flg:1] bind=focused>
		<section.counter[pe:none]>
			<Counter[zi:2 pe:all]>
		<footer[zi:1]>
			<span[js:start]>
				"Dedicated to our worldwide strongest idol: "
				<a[pe:all] href="https://www.youtube.com/@AkaiHaato"> "Akai Haato"
				" ❤️"
			<FocusToggle[js:center] bind=focused>
			<span[js:end]>
				"And thanks " 
				<a href="https://twitter.com/walfieee/status/1343707337777946628"> "@Walfie" 
				" for the illustration!"

imba.mount <App>, document.getElementById('app')
