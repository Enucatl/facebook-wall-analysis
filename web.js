var gzippo = require('gzippo');
var express = require('express');
var app = express();

app.use(gzippo.staticGzip("" + __dirname + "/.tmp"));
app.listen(process.env.PORT || 5000);
