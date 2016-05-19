//var Users = require('Users')
var loopback = require('loopback');
var app = require('../../server/server');

module.exports = function(Game) {
  //console.log(Users);
  var globalId;
  Game.join = function(cb) {
    var ctx = loopback.getCurrentContext();
    // Get the current access token
    var accessToken = ctx.get('accessToken');

    globalId = ctx.active.http.req.accessToken.__data.userId;

    Game.findOne({'active': true}, {'order': 'created DESC'}, function(err0, getGame) {
      if(err0) {
        console.error(err0);
      } else {
        if(!!getGame) {
          cb(null, getGame);
        } else {
          Game.create({
            gameid: 0,
            active: true,
            created: (new Date()).toISOString(),
            tournamentTournamentid: 0
          }, createGame)
        }
      }
    })

    // app.models.UserHasTeam.findOne({'userid': globalId}, function(err, userTeamObj) {
    //   if(err) {
    //     console.error(err);
    //   } else {
    //     if(!userTeamObj) {
    //       app.models.Team.create({
    //         idteam: 0,
    //         pair: false,
    //         active: true,
    //         gameid: 1
    //       }, function(err2, newTeam) {
    //         if(err2) {
    //           console.error(err2)
    //         } else {
    //           app.models.UserHasTeam.create({'userid': userId, 'idteam': newTeam.$idteam}, function(err3, newUserTeam) {
    //             cb(null, newUserTeam);
    //           });
    //         }
    //       });
    //
    //     } else {
    //       cb(null, userTeamObj);
    //     }
    //   }
    // });
    }

  var createGame = function(err, _game) {
    if(err) {
      console.error(err);
    } else {
      app.models.UserHasTeam.findOne({'userid': globalId}, getUserHasTeamList);
    }
  };

  Game.remoteMethod('join', {
    http: {path:'/join', verb: 'get', status: 200, errorStatus: 400},
    description: 'Creates a new game or joins into an existing one.',
    returns: {arg: 'result', type: 'object'}
  })
}
