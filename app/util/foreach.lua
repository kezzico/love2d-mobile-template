function forEach(table_1dex, callback)
	for i=1, #table_1dex do
		callback(table_1dex[i], i)
	end
end

function forEachPair(table_pairs, callback)
  for key in pairs(table_pairs) do
    local t = table_pairs[key]

    callback(t)
  end
end


function map(table_1dex, callback)
  local m = { }
  for i=1, #table_1dex do
    table.insert( m, callback(table_1dex[i]) )
  end

  return m
end

function appendTable(table1, table2)
    for _, value in ipairs(table2) do
        table.insert(table1, value)
    end
    return table1
end

function flatten(t, flat)
  flat = flat or { }  -- create flat table if not provided
  for k, v in pairs(t) do         -- iterate all keys, numeric or string
    if type(v) == "table" then
      flatten(v, flat)        -- recurse into inner table
    else
      table.insert(flat, v)   -- insert leaf value
    end
  end

  return flat
end

function reduce(tbl, reducer)
  local s = 0
  -- using pairs here so that nil entries in the table won't truncate the loop
  -- side effect: named table entries will be included in the loop, so filter for numbers only
  for i, row in pairs(tbl) do
    if type(i) == 'number' then s = reducer(s, tbl[i], i) end
  end

  return s
end

function ternary(condition, a, b)
  if condition then
    return a
  else
    return b
  end
end

function count(tbl, filter_func)
  local total = 0
  for i = 1, #tbl do
    if filter_func(tbl[i], i) then
      total = total + 1
    end
  end

  return total
end


function filter(tbl, filter_func)
  local ftbl = { }
  for i, row in ipairs(tbl) do
    if filter_func(row, i) then
      table.insert(ftbl, row)
    end
  end

  return ftbl
end

function forEachCell(grid, fn)
    for x, column in ipairs(grid) do
        for y, cell in ipairs(column) do
            fn(cell, x, y)
        end
    end
end
-- Example usage:
return {
    forEach = forEach,
    forEachPair = forEachPair,
    map = map,
    appendTable = appendTable,
    flatten = flatten,
    reduce = reduce,
    ternary = ternary,
    count = count,
    filter = filter,
    forEachCell = forEachCell

}