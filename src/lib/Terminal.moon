import graphics from love

keyConstants = require "lib.keyConstants"
History = require "lib.History"

font = graphics.newFont "fonts/VeraMono.ttf", 15
width = graphics.getWidth!

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

  write: (text) =>
    @display ..= text
    if text != "\n"
      _, lines = font\getWrap(@display, width)
      @display = table.concat lines, "\n"
    historyCount = 1 + select 2, @display\gsub "\n", "\n"
    if historyCount > lineCount
      first_eol = @display\find "\n"
      @display = @display\sub first_eol + 1

  update: (dt) =>
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

  textinput: (text) =>
    @write text
    @input ..= text

  keypressed: (key) =>
    switch key
      when "up"
        @display = @display\sub 1, -(#@input + 1)
        @input = @actions\back(@input)
        @write(@input)
      when "down"
        @display = @display\sub 1, -(#@input + 1)
        @input = @actions\foreward(@input)
        @write(@input)
      when "return"
        @keysHeld[key] = 0
        @write("\n")
        @actions\add(@input)
        print(@input) -- TODO do something to run it
        @write("> ")
        @input = ""
      when "backspace"
        @keysHeld[key] = 0
        if #@input > 0
          if @display\sub(-1) != "\n"
            @input = @input\sub 1, -2
          @display = @display\sub 1, -2
      -- when "delete"
      else
        unless keyConstants.character[key]
          print key -- TEMP

  keyreleased: (key) =>
    @keysHeld[key] = nil

return Terminal
