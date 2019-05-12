const express = require('express')
var http = require('http')
var morgan = require('morgan')
var cors = require('cors')
var bodyParser = require('body-parser')
const PORT = 3000;
const app = express()

app.server = http.createServer(app);

app.use(morgan('dev'));
 
app.use(cors({
    exposedHeaders: "*"
}));

app.use(bodyParser.json({
    limit: '50mb'
}));

console.log("Hi");

app.set('root', __dirname);

app.server.listen(process.env.PORT || PORT, () => {
    console.log(`App is running on port ${app.server.address().port}`);
});

// export default app;