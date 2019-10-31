full_name = (vessel, indefinite_article) ->
  result = ""
  if vessel.attribute
    result = vessel.attribute .. " "
  if vessel.name
    result ..= vessel.name
  else
    result ..= "vessel"
  if indefinite_article
    switch result\sub 1, 1
      when "a", "e", "i", "o", "u"
        result = "an " .. result
      else
        result = "a " .. result
  return result

actions = {
  look: (vessels, args) ->
    return "\nNot implemented."
  create: (vessels, args) ->
    if args
      if vessel = vessels\create args
        return "\nYou created #{full_name vessel, true}."
    return "\nInvalid action."
  become: (vessels, args) ->
    if args
      if vessels\become args
        return actions.look vessels
      else
        return "\nThere is no such vessel."
    else
      return "\nYou must select a vessel to become."
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
    if args
      if vessel = vessels\get args
        name = full_name vessel, true
        return "\n#{name\sub(1, 1)\upper! .. name\sub 2}, its ID is #{vessel.id}"
      else
        return "\nThere is no such vessel."
    else
      return "\nYou must select a vessel to inspect."
  trigger: (vessels, args) ->
    return "\nNot implemented."
  program: (vessels, args) ->
    return "\nNot implemented."
  use: (vessels, args) ->
    return "\nNot implemented."
  cast: (vessels, args) ->
    return "\nNot implemented."
  echo: (vessels, args) ->
    return "\n#{args}"
}

class Parser
  new: (vesselManager) =>
    @vesselManager = vesselManager

  act: (input) =>
    assert type(input) == "string", "Actions must be strings."
    index = input\find(" ") or #input + 1
    action = input\sub 1, index - 1
    if actions[action]
      actions[action](@vesselManager, input\sub(index + 1))
    else
      return "\nYou cannot '#{action}' here. (Need help? Try 'help' or 'learn')"
