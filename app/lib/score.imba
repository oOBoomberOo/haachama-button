export default tag Scoreboard
	data\bigint = 0n

	formatter = Intl.NumberFormat('en-US', { })
	
	css m:0 p:0
		c:var(--primary)
		txs: 1px 1px var(--text), 1px -1px var(--text), -1px 1px var(--text), -1px -1px var(--text)

	<self> "{formatter.format data}"