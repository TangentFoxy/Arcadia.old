import graphics from love

keyConstants = require "lib.keyConstants"
History = require "lib.History"

font = graphics.newFont "fonts/VeraMono.ttf", 15
lineHeight = font\getHeight!
lineCount = math.floor graphics.getHeight! / lineHeight

characterWidth = font\getWidth " "
lineWidth = math.floor love.graphics.getWidth! / characterWidth

keyRepeatThreshold = 0.5
keyRepeatInterval = 0.03

class Terminal
  new: =>
    @display = "> "
    @keysHeld = {}
    @actions = History!
    @input = ""

  update: (dt) =>
    -- remove text scrolled off-screen
    -- TODO consider moving this to something updated every time display is updated
    historyCount = 1 + select 2, @display\gsub "\n", "\n"
    if historyCount > lineCount
      first_eol = @display\find "\n"
      @display = @display\sub first_eol + 1

    -- handle key repetition
    for key, time in pairs @keysHeld
      time += dt
      if time >= keyRepeatThreshold
        @keypressed key
        time -= keyRepeatInterval
      @keysHeld[key] = time

  draw: =>
    graphics.setFont font
    graphics.print @display
    -- graphics.printf @display, 0, 0, love.graphics.getWidth!

  textinput: (text) =>
    @display ..= text
    @input ..= text

  keypressed: (key) =>
    switch key
      when "up"
        @display = @display\sub 1, -(#@input + 1)
        @input = @actions\back!
        @display ..= @input
      when "down"
        @display = @display\sub 1, -(#@input + 1)
        @input = @actions\foreward!
        @display ..= @input
      when "return"
        @keysHeld[key] = 0
        @display ..= "\n"
        @actions\add(@input)
        print(@input) -- TODO do something to run it
        @display ..= "> "
        @input = ""
      when "backspace"
        @keysHeld[key] = 0
        if #@input > 0
          @input = @input\sub 1, -2
          @display = @display\sub 1, -2
      -- when "delete"
      else
        print key -- TEMP

  keyreleased: (key) =>
    @keysHeld[key] = nil

return Terminal
