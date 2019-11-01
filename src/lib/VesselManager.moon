-- enable: any, id
--  match additional specifiers?
parseName = (input, enable={}) ->
  -- split into words
  words = {}
  while #input > 0
    index = input\find(" ") or #input + 1
    words[#words + 1] = input\sub 1, index - 1
    input = input\sub(index + 1)
  if #words < 1
    return nil
  -- ignore indefinite articles
  for word in *{"a", "an", "the"}
    if words[1] == word
      table.remove words, 1
      break
  if #words < 1
    return nil
  -- returning a random vessel?
  local any
  if enable.any and words[1] == "any"
    table.remove words, 1
    any = true
  -- attribute specified?
  local attribute
  if #words > 1
    attribute = table.remove words, 1
  -- name specified?
  local name
  if #words > 0
    name = table.remove words, 1
  -- match specified id (yes, this ignores the typed name entirely)
  local id
  if enable.id
    if index = name\find "#"
      id = tonumber name\sub index + 1
  -- return result table
  return { :any, :attribute, :name, :id }

class VesselManager
  new: (vessels, save={}) =>
    @vessels = vessels or {
      {
        name: "void"
        owners: { true }
        parent: 1
        creator: "void"
      }
    }
    @possessed = save.possessed and @vessels[save.possessed] or @vessels[1]
    @permissions = save.permissions or { [@possessed.id]: true }
    @nextID = save.nextID or #@vessels + 1

    @indices = {
      children: {} -- hashmap: parent id = hashmap: child id = true
    }
    for id = 1, #vessels
      vessel = vessels[i]
      parent = vessel.parent
      -- fix missing/invalid ids
      vessel.id = id
      -- update indices
      children = @indices.children
      if children[parent]
        children[parent][id] = true
      else
        children[parent] = { [id]: true }

  create: (input) => -- accepts "[a/an/the] [attribute] [name]"
    -- get attribute and/or name
    import attribute, name from parseName(input)
    -- get creator string to be used
    creator = @possessed.attribute
    if creator and #creator > 0
      creator ..= " " .. @possessed.name
    else
      creator = @possessed.name
    -- get next available ID and increment it
    newID = @nextID
    @nextID += 1
    -- create the new vessel
    vessel = {
      id: newID
      attribute: attribute
      name: name
      owners: { [@possessed.id]: true }
      parent: @possessed.parent
      creator: creator
    }
    -- fix ownership chain
    for id in pairs(@possessed.owners)
      vessel.owners[id] = true
    -- save the new vessel
    @vessels[newID] = vessel
    -- add to indices
    parent = vessel.parent
    children = @indices.children
    if children[parent]
      children[parent][vessel.id] = true
    else
      children[parent] = { [id]: true }
    return vessel

  become: (input) =>
    import any, attribute, name, id from parseName(input, { any: true, id: true })
    -- search siblings only, update possessed, update permissions chain

  get: (input) => -- accepts "[a/an/the/any] [attribute] [name][#id]"
    import any, attribute, name, id from parseName(input, { any: true, id: true })
    if id
      return @vessels[id]
    -- match against vessels
    matches = {}
    siblings = @indices.children[@possessed.parent]
    -- search by name in siblings, then all vessels; until matches found
    if name
      for sibling_id in pairs siblings
        vessel = @vessels[sibling_id]
        if vessel.name == name
          matches[#matches + 1] = vessel
      if #matches < 1
        for _, vessel in pairs(@vessels)
          matches[#matches + 1] = vessel
      if attribute                       -- if attribute, remove invalid matches
        for i = #matches, 1, -1
          vessel = matches[i]
          if vessel.attribute != attribute
            table.remove matches, i
    -- else search by attribute in siblings, then all vessels; until matches
    elseif attribute
      for sibling_id in pairs siblings
        vessel = @vessels[sibling_id]
        if vessel.attribute == attribute
          matches[#matches + 1] = vessel
      if #matches < 1
        for _, vessel in pairs(@vessels)
          matches[#matches + 1] = vessel
    -- for "any" only
    else
      matches = @vessels
    -- if any specified, return a random match, else return first match
    local r
    if any
      r = love.math.random #vessels
    else
      r = 1
    return matches[r]
