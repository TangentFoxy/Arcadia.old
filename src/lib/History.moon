class History
  new: () =>
    @[1] = ""
    @index = 1

  add: (input) =>
    if #input > 0
      new = #@           -- new index will be at end
      if #@[#@] != 0     -- if end is occupied, we will need to increment
        if @index == new --   if our index is at the end
          @index += 1    --     increment our index
        new += 1

      @[new] = input

  back: () =>
    @index = math.max @index - 1, 1
    return @[@index]

  foreward: () =>
    @index = math.min @index + 1, #@
    return @[@index]
