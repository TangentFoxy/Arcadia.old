# Vessel Format

In Lua, all vessels are stored in a hashmap that resembles an array:

```
vessels = {
  [id]: {
    name: ""        -- no spaces
    attribute: ""   -- no spaces
    note: ""        -- can contain anything
    owners: {}      -- hashmap: owner id = true
    parent: #       -- integer id
    permissions: {} -- hashmap: denied permission = true
    programs: {}    -- hashmap: name = code (string)
    creator: ""     -- full name of vessel that created this vessel (static)
  }
}
```

In addition to the vessels, a `nextID` must be stored, and the ID of the
currently possessed vessel.
