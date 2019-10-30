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

vessels = {
  {
    name: "library"
    owners: {1}
    parent: 1
  }
  {
    name: "ghost"
    owners: {true}
    parent: 1
    note: "Well, well, hello there."
  }
  {
    name: "map"
    owners: {true, true}
    parent: 2
    note: "A basic map"
  }
}

indices: {
  children: {} -- index is parent id, is an object, a hashmap of ids of children
}
for i = 1, #vessels
  vessel = vessels[i]
  parent = vessel.parent
  children = indices.children
  if children[parent]
    children[parent][i] = true
  else
    children[parent] = { [i]: true }

possessed = 2

actions = {
  look: (args, @) ->
    @write "\nNot implemented."
  create: (args, @) ->
    @write "\nNot implemented."
  become: (args, @) ->
    @write "\nNot implemented."
  enter: (args, @) ->
    @write "\nNot implemented."
  leave: (args, @) ->
    @write "\nNot implemented."
  warp: (args, @) ->
    @write "\nNot implemented."
  take: (args, @) ->
    @write "\nNot implemented."
  drop: (args, @) ->
    @write "\nNot implemented."
  inventory: (args, @) ->
    @write "\nNot implemented."
  move: (args, @) ->
    @write "\nNot implemented."
  learn: (args, @) ->
    @write "\nNot implemented."
  note: (args, @) ->
    @write "\nNot implemented."
  transform: (args, @) ->
    @write "\nNot implemented."
  inspect: (args, @) ->
    @write "\nNot implemented."
  trigger: (args, @) ->
    @write "\nNot implemented."
  program: (args, @) ->
    @write "\nNot implemented."
  use: (args, @) ->
    @write "\nNot implemented."
  cast: (args, @) ->
    @write "\nNot implemented."
  echo: (args, @) ->
    @write "\nNot implemented."
}

run = (input, @) ->
  index = input\find(" ") or #input + 1
  action = input\sub 1, index - 1
  if actions[action]
    actions[action](input\sub(index + 1), @)
  else
    @write "\nYou cannot '#{action}' here. (Need help? Try 'help' or 'learn')"

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
        @actions\add(@input)
        run(@input, @)
        @write("\n> ")
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
