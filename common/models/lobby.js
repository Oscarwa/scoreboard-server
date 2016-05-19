var loopback = require('loopback');
var app = require('../../server/server');

module.exports = function(Lobby) {
  //console.log(Users);
  //var globalId;
  Lobby.join = function(cb) {
    var ctx = loopback.getCurrentContext();
    // // Get the current access token
    var accessToken = ctx.get('accessToken');
    //
    globalId = ctx.active.http.req.accessToken.__data.userId;
    //
    Lobby.findOne({'active': true}, {'order': 'created DESC'}, function(err0, getLobby) {
      if(err0) {
        console.error(err0);
      } else {
        if(!!getLobby) {
          app.models.Match.find({'lobbyLobbyid': getLobby.lobbyId}, function(error1, matches) {
            cb(null, matches);
          });
        } else {
          Lobby.create({
            lobbyid: 0,
            active: true,
            created: (new Date()).toISOString(),
            tournamentTournamentid: 0
          }, createLobby);
        }
      }
    });
  }

  // var createLobby = function(err, _lobby) {
  //   if(err) {
  //     console.error(err);
  //   } else {
  //     app.models.UserHasTeam.findOne({'userid': globalId}, getUserHasTeamList);
  //   }
  // };
  //
  // var getUserHasTeamList = function(err, _userHasTeam) {
  //
  // };

  Lobby.remoteMethod('join', {
    http: {path:'/join', verb: 'get', status: 200, errorStatus: 400},
    description: 'Creates a new Lobby or joins into an existing one.',
    returns: {arg: 'result', type: 'object'}
  })
}
