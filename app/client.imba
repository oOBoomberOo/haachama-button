import './assets/app.css'
import Counter from './lib/counter'
import logo from "./assets/imba.svg"

tag app
	css .logo h:6em p:1.5em
	<self>
		<Counter>

imba.mount <app>, document.getElementById('app')
