vessels = {
  {
    name: "library"
    owners: {true, true}
    parent: 1
    creator: "ghost"
  }
  {
    name: "ghost"
    owners: {true, true}
    parent: 1
    note: "Well, well, hello there."
    creator: "ghost"
  }
  {
    name: "map"
    owners: {true, true}
    parent: 2
    note: "A basic map"
    creator: "ghost"
  }
}

save = {
  possessed: 2
  permissions: { [2]: true }
  nextID: 4
}

return { vessels, :save }
