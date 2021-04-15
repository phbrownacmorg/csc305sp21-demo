// Load the Express framework
const express = require('express');

// Create the app object
const app = express();

// Invoke the handler for static files
app.use(express.static('public'));

// Give the app a handler for a GET request to
//   the root of the document tree.  The app
//   handler takes the request and response
//   objects as arguments.
//app.get('/', (req, res) => {
//  res.send('Hello CSC305!')
//});

app.get('/', function (req, res) {
    console.log('Initial page load');
    //console.log(req);
    if (!req.query.form_submission) {
        console.log('Serving page');
   res.sendFile( __dirname + "/" + "index.html" );
    }
    else {
        console.log('Form submission');
        response = {
            first_name:req.query.first_name,
            last_name:req.query.last_name
        };
        console.log(response);
        res.end(JSON.stringify(response));
    }
})

// Tell the app to listen on port 3000 for
//   incoming requests.
app.listen(3000, () => {
  console.log('server started');
});