/**
 * Created by arvind on 3/2/18.
 */

const express = require('express');
const app = express();
const path = require('path');
// const html = require('./app/index.html');

app.use(express.static(path.join(__dirname, 'build')));

app.get('/render', (req, res) => {
//  console.log(path.join(__dirname, '/src/index.html'));
  res.sendFile(path.join(__dirname, '/build/index.html'));
});

app.listen(4000, () => {
  console.log("Listening at port 4000");
});
