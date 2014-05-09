# Description:
#   Inspect the data in redis easily
#
# Commands:
#   hubot show users - Display all users that hubot knows about
#   hubot show storage - Display the contents that are persisted in the brain


Util = require "util"

module.exports = (robot) ->
  robot.respond /show storage$/i, (msg) ->
    output = JSON.stringify robot.brain.data, null, 4
    console.log output
    msg.send output
  
  robot.respond /hello$/i, (msg) ->
    output = "World"
    msg.send output 	

  robot.respond /time$/i, (msg) -> 
    output = "Server time is : " + new Date
    msg.send output

  robot.respond /set storage ([\s\S]*)$/i, (msg) ->
    backup = robot.brain.data
    console.log "Swapping brain value. Backup: #{JSON.stringify robot.brain.data, 2}"
    robot.brain.data = JSON.parse( msg.match[1] )
    robot.brain.save()
    msg.send "Done, previous brain was #{JSON.stringify backup, 2}"
   
   robot.respond /ls$/i, (msg)->
       output = JSON.stringify robot.brain.data, 2
       msg.send output
   
  robot.respond /show users$/i, (msg) ->
    response = ""

    for own key, user of robot.brain.data.users
      response += "#{user.id} #{user.name}"
      response += " <#{user.email_address}>" if user.email_address
      response += "\n"

    msg.send response

  robot.respond /SAVE (.*)$/i, (msg) ->
	  fs = require "fs"
	  dir = "."
	  fs.writeFile "#{dir}/msg", msg.match[1]
	  msg.send "Will remind of : " + msg.match[1]
