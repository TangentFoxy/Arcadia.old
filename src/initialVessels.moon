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

possessed = 2

return {
  vessels,
  possessed
}
