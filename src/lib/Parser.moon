actions = {
  look: (vessels, args) ->
    return "\nNot implemented."
  create: (vessels, args) ->
    return "\nNot implemented."
  become: (vessels, args) ->
    return "\nNot implemented."
  enter: (vessels, args) ->
    return "\nNot implemented."
  leave: (vessels, args) ->
    return "\nNot implemented."
  warp: (vessels, args) ->
    return "\nNot implemented."
  take: (vessels, args) ->
    return "\nNot implemented."
  drop: (vessels, args) ->
    return "\nNot implemented."
  inventory: (vessels, args) ->
    return "\nNot implemented."
  move: (vessels, args) ->
    return "\nNot implemented."
  learn: (vessels, args) ->
    return "\nNot implemented."
  note: (vessels, args) ->
    return "\nNot implemented."
  transform: (vessels, args) ->
    return "\nNot implemented."
  inspect: (vessels, args) ->
    return "\nNot implemented."
  trigger: (vessels, args) ->
    return "\nNot implemented."
  program: (vessels, args) ->
    return "\nNot implemented."
  use: (vessels, args) ->
    return "\nNot implemented."
  cast: (vessels, args) ->
    return "\nNot implemented."
  echo: (vessels, args) ->
    return "\nNot implemented."
}

class Parser
  new: (vesselManager) =>
    @vesselManager = vesselManager

  act: (input) =>
    index = input\find(" ") or #input + 1
    action = input\sub 1, index - 1
    if actions[action]
      actions[action](@vesselManager, input\sub index + 1)
    else
      return "\nYou cannot '#{action}' here. (Need help? Try 'help' or 'learn')"
