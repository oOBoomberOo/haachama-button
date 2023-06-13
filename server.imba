import express from 'express'
import compression from 'compression'
import index from './app/index.html'
import api from "./server/api"

# Using Imba with Express as the server is quick to set up:
const app = express()
const port = process.env.PORT or 3000

app.use(api)

app.get("/avatar/:name") do(req,res)
	const file = req.params.name
	res.sendFile(`{__dirname}/app/assets/avatar/{file}.gif`)

app.get("/sounds/:name") do(req,res)
	const file = req.params.name
	res.sendFile(`{__dirname}/app/assets/sounds/{file}.mp3`)

app.use("/assets", compression(), express.static('app/assets/'))

# catch-all route that returns our index.html
app.get(/.*/) do(req,res)
	res.send(index.body)

# Express is set up and ready to go!
imba.serve(app.listen(port))
