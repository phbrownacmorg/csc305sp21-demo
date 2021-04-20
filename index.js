// Load the Express framework
const express = require('express');

// Create the app object
const app = express();

//Loads the handlebars module
const handlebars = require('express-handlebars');
//Sets our app to use the handlebars engine
app.set('view engine', 'hbs');

//Sets handlebars configurations (we will go through them later on)
app.engine('hbs', handlebars({
    layoutsDir: __dirname + '/views/layouts',
    extname: 'hbs',
    defaultLayout: 'index',
    partialsDir: __dirname + '/views/partials/'
}));

// Invoke the handler for static files
app.use(express.static('public'));

// Give the app a handler for a GET request to
//   the root of the document tree.  The app
//   handler takes the request and response
//   objects as arguments.
//app.get('/', (req, res) => {
//  res.send('Hello CSC305!')
//});

app.get('/', (req, res) => {
    if (!req.query.form_submission) {
        //Serves the body of the page aka "main.handlebars" to the container //aka "index.handlebars"
        res.render('main');
    }
    else if (req.query.to_do === 'query') {
        res.render('query', {
             first_name:req.query.first_name,
             last_name:req.query.last_name
        });
    }
    else if (req.query.to_do === 'add') {
        res.render('adduser', {
             first_name:req.query.first_name,
             last_name:req.query.last_name
        });
    }
    else { // List users
        res.render('listusers');
    }
});

// app.get('/', function (req, res) {
//     console.log('Initial page load');
//     //console.log(req);
//     if (!req.query.form_submission) {
//         console.log('Serving page');
//         res.sendFile( __dirname + "/" + "index.html" );
//     }
//     else {
//         console.log('Form submission');
//         response = {
//             first_name:req.query.first_name,
//             last_name:req.query.last_name
//         };
//         console.log(response);
//         res.end('<p>' + JSON.stringify(response) + '</p>');
//     }
// })

// Tell the app to listen on port 3000 for
//   incoming requests.
app.listen(3000, () => {
  console.log('server started');
});