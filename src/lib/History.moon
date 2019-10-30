class History
  new: () =>
    @[1] = ""
    @index = 1

  add: (input) =>
    if #input > 0
      @[#@] = input  -- place at end
      @[#@ + 1] = "" -- create new empty space
      @index = #@    -- set index to new space

  back: (input) =>
    @[#@] = input -- whatever was being edited stays available at end of history
    @index = math.max @index - 1, 1
    return @[@index]

  foreward: (input) =>
    @[#@] = input -- whatever was being edited stays available at end of history
    @index = math.min @index + 1, #@
    return @[@index]
