// Load the Express framework
const express = require('express');
// Load the sqlite3 module
const sqlite3 = require('sqlite3').verbose();

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


function openDB(filename) {
    if (!filename) {
        filename = __dirname + "/SQL/" + "grasshopper-air.sqlite";
    }
    return new sqlite3.Database(filename,
        (err) => {
            if (err) {
                console.error(err.message);
            }
            console.log('Connected to ' + filename);
        })
}

function closeDB(database) {
    database.close((err) => {
        if (err) {
            console.error(err.message);
        }
        console.log('Closed the database connection.');
    });
}

// Give the app a handler for a GET request to
//   the root of the document tree.  The app
//   handler takes the request and response
//   objects as arguments.
//app.get('/', (req, res) => {
//  res.send('Hello CSC305!')
//});

app.get('/', (req, res) => {
    let db = openDB();
    if (!req.query.form_submission) {
        //Serves the body of the page aka "main.handlebars" to the container //aka "index.handlebars"
        res.render('main');
    }
    else if (req.query.to_do === 'query') {
        sql = "select * from Passengers where FirstName=$first and LastName=$last;";
        db.get(sql, { 
                $first: req.query.first_name, 
                $last: req.query.last_name
            }, (err, row) => {
            if (err) {
                throw err;
            }
            console.log(row);
            res.render('query', {
                first_name:req.query.first_name,
                last_name:req.query.last_name,
                person: row
            });
        });
    }
    else if (req.query.to_do === 'add') {
        res.render('adduser', {
             first_name:req.query.first_name,
             last_name:req.query.last_name
        });
    }
    else { // List users
        let sql = "select * from passengers;";
        db.all(sql, [], (err, rows) => {
            if (err) {
                throw err;
            }
            //console.log(rows);
            res.render('listusers', {passengers: rows});
        })
    }
    closeDB(db);
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

