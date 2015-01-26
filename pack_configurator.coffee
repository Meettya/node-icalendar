###
This is common package config
used in server and in build comand
###

path = require 'path'

web_modules_path  = path.join __dirname, 'web_modules'
frontend_src_path = path.join __dirname

get_module = (name) ->
  path.join web_modules_path, name

get_pack_config = (filename) ->

  switch filename
    when 'index'
      bundle : 
        icalendar : path.join frontend_src_path, filename
      replacement :
        assert      : get_module 'assert'
        util        : get_module 'util'

    else
      throw Error "dont know |#{filename}| settings"

module.exports = {
  get_pack_config
}