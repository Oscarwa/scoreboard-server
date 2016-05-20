var loopback = require('loopback');

var fs = require("fs");

var ds = loopback.createDataSource('mysql',{
  "host":"127.0.0.1",
  "port":"3306",
  "database":"scorepoint",
  "username":"root",
  "password": "root"
});

ds.discoverModelDefinitions({
  all: true,
  schema: 'scorepoint'
}, function(err, models){
  models.forEach(function (def) {
    // def.name ~ the model name

    console.log(def.name + '\n');

    ds.discoverSchema(def.name, null, function (err, schema) {
      fs.writeFile("../faemodels/" + def.name + ".json",JSON.stringify(schema,null,2), function(err) {
        if(err){
          console.log(err);
          return;
        }
        console.log(def.name + ".json " + 'created');
      });
    });
  });
})

/*ds.discoverAndBuildModels('User',{
  visited:{},
  associations:true
}, function(err, models){

  if(err){
    console.error(err);
    return ;
  }

  models.User.findOne({ }, function(err,inv){
    if(err){
      console.error(err);
      return ;
    }

    console.log("inventory: ", inv);

  })
})*/
