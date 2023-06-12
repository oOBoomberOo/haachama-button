import Haachama, { haachamaSet } from "./haachama";
import DistributedCounter from "./distributed_counter"
import store from "./store"

import * as player from "./player"

def parseCount response\Response
	unless response.status is 200
		const error = await response.text()
		throw new Error(error)

	const data = await response.json()
	BigInt(data.count)

def fetcher
	try
		const res = await window.fetch '/count'
		return await parseCount res
	catch e
		console.error `Failed to fetch score: {e}`

def incrementer
	try
		const res = await window.fetch '/increment', { method: 'POST' }
		return await parseCount res
	catch e
		console.error `Failed to increment score: {e}`

export default tag Counter
	personalScore = store "personal"
	globalScore = store "global"

	counter = new DistributedCounter 'global-counter', globalScore, fetcher, incrementer

	haachama = haachamaSet()
	
	def mount
		await counter.init!
		await player.preload!
	
	def unmount
		counter.destroy!
	
	def increment
		personalScore.value += 1n
		await counter.increment!
		haachama.add player.select!

	
	css ta:center
		g:15px
		d:flex
		fld:column
		ai:center
		c:var(--text)

	css .score
		m:0 p:0
		c:var(--primary)
		txs: 1px 1px var(--text), 1px -1px var(--text), -1px 1px var(--text), -1px -1px var(--text)

	css button
		p:3 5
		fs:2xl
		bg:var(--primary)
		c:var(--text)
		ol:none
		bd:none
		rd:15px
		w:fit-content
	css button@hover
		cursor:pointer
		bg:red6
	css button@active
		bg:red7
		transform:translateY(2px)
	
	formatter = Intl.NumberFormat('en-US', { })
	
	css .scoreboard
		m:0 p:0
		c:var(--primary)
		txs: 1px 1px var(--text), 1px -1px var(--text), -1px 1px var(--text), -1px -1px var(--text)

	<self[c@suspended: red4]>
		<global>
			for { x, y, angle, icon } of haachama.content
				<Haachama x=x y=y angle=angle icon=icon>

		<span.scoreboard[fs:48px]>
			<span id="global-counter"> "{globalScore.format!}"
		<span.scoreboard[fs:24px]> "{personalScore.format!}"
		<button @click=increment> "HAACHAMA!"

