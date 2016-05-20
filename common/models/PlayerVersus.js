//var Users = require('Users')
var loopback = require('loopback');
var app = require('../../server/server');
var Q = require("q");


module.exports = function(Playerversus) {





  //console.log(Users);
  var globalId;
  Playerversus.recommended = function(cb) {
    var ctx = loopback.getCurrentContext();
    // Get the current access token
    var accessToken = ctx.get('accessToken');

    globalId = ctx.active.http.req.accessToken.__data.userId;

    Playerversus.find({'id': globalId}, {'order': 'playedtimes DESC',limit: 5}, function(err0, recommended) {
      if(err0) {
        console.error(err0);
      } else {
        cb(null,recommended);
      }
    })
  };


  Playerversus.disableRemoteMethod('__get__', true);
  Playerversus.disableRemoteMethod('create', true);                // Removes (POST) /products
  Playerversus.disableRemoteMethod('upsert', true);                // Removes (PUT) /products
  Playerversus.disableRemoteMethod('deleteById', true);            // Removes (DELETE) /products/:id
  Playerversus.disableRemoteMethod("updateAll", true);               // Removes (POST) /products/update
  Playerversus.disableRemoteMethod("updateAttributes", false);       // Removes (PUT) /products/:id
  Playerversus.disableRemoteMethod('createChangeStream', true);    // removes (GET|POST) /products/change-stream

  Playerversus.remoteMethod('recommended', {
    http: {path:'/recommended', verb: 'get', status: 200, errorStatus: 400},
    description: 'get recommended players to request a conquest based on players who play played more with you.',
    returns: {arg: 'result', type: 'object'}
  })
}
