###
node.js assert shim
###

module.exports = 
  equal : (a, b) ->
    unless a is b
      throw Error "assert test fail! |#{a}| isnt |#{b}|"

    null