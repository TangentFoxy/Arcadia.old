import graphics from love

keyConstants = require "lib.keyConstants"

font = graphics.newFont "fonts/VeraMono.ttf", 13
lineHeight = font\getHeight!
lineCount = math.floor graphics.getHeight! / lineHeight

keyRepeatThreshold = 0.5
keyRepeatInterval = 0.03

class Terminal
  new: =>
    @display = "> "
    @keysHeld = {}
    @command_history = {""}
    @current_command = 1

  update: (dt) =>
    -- remove text scrolled off-screen
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
    graphics.print @display, 1, -1

  textinput: (text) =>
    @display ..= text
    @command_history[@current_command] ..= text

  keypressed: (key) =>
    switch key
      when "up"
        @display = @display\sub 1, -(#@command_history[@current_command] + 1)
        @current_command = math.max @current_command - 1, 1
        @display ..= @command_history[@current_command]
      when "down"
        @display = @display\sub 1, -(#@command_history[@current_command] + 1)
        @current_command = math.min @current_command + 1, #@command_history
        @display ..= @command_history[@current_command]
      when "return"
        @keysHeld[key] = 0
        @display ..= "\n"
        print(@command_history[@current_command]) -- TODO do something to run it
        @display ..= "> "
        @current_command = #@command_history
        if #@command_history[@current_command] > 0
          @current_command += 1
          @command_history[@current_command] = ""
      when "backspace"
        @keysHeld[key] = 0
        if #@command_history[@current_command] > 0
          @command_history[@current_command] = @command_history[@current_command]\sub 1, -2
          @display = @display\sub 1, -2
      -- when "delete"
      else
        print key -- TEMP

  keyreleased: (key) =>
    @keysHeld[key] = nil

return Terminal
