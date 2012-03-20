var mongo = require('mongojs');

function runMongo () {
    
    var url = 'test';
    var collection = ['users', 'reports'];
    var db = mongo.connect(url, collection);
    
    console.log(mongo);
    console.log('connected to ' + db);
    
    db.users.find(
        {sex: 'female'},
        function (err, users) {
            if (err || !users) 
                console.log('no female users found');
            else users.forEach(
                function (femaleUser) {
                    console.log(femaleUser);
                }
            )
        }
    );
 
}

exports.run = runMongo;

/*
 * Create unique ID:
 * db.bson.ObjectID.createPk()
 * 
 * Get last insert ID:
 * function getLastId(err, doc) {
 *   if (err) 
 *     throw err;
 *   else 
 *     console.log(doc._id);
 * }
 * db.contacts.insert( { ‘name’ : ‘TEST’, ‘gravatar’ : ‘TEST’ } , getLastId );
 * 
 */