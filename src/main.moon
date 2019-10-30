Terminal = require "lib.Terminal"

terminal = Terminal!

love.update = (dt) ->
  terminal\update dt

love.draw = ->
  terminal\draw!

love.textinput = (text) ->
  terminal\textinput text

love.keypressed = (key) ->
  terminal\keypressed key

love.keyreleased = (key) ->
  terminal\keyreleased key
