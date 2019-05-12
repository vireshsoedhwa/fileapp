const http = require('http'); 
const app = require('express')
const cors = require('cors')
const morgan = require('morgan')
const bp = require('body-parser')

const PORT = 3000;

app.server = http.createServer(app);