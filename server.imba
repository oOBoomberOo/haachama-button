import express from 'express'
import index from './app/index.html'
import api from "./server/api"

# Using Imba with Express as the server is quick to set up:
const app = express()
const port = process.env.PORT or 3000

app.use(api)

# catch-all route that returns our index.html
app.get(/.*/) do(req,res)
	# only render the html for requests that prefer an html response
	unless req.accepts(['image/*', 'html']) == 'html'
		return res.sendStatus(404)

	res.send(index.body)

# Express is set up and ready to go!
imba.serve(app.listen(port))
