class VesselManager
  new: (vessels, possessed) =>
    @vessels = vessels or {
      {
        name: "void"
        owners: { true }
        parent: 1
        creator: "void"
      }
    }
    @possessed = possessed or 1

    @indices = {
      children: {} -- hashmap: parent = hashmap: child id = true
    }
    for i = 1, #vessels
      vessel = vessels[i]
      parent = vessel.parent
      children = @indices.children
      if children[parent]
        children[parent][i] = true
      else
        children[parent] = { [i]: true }
