-- fill a table with a value, repeating if necessary
-- @param n number
-- @param value any
-- @return table
table.fill = function(n, value)
  local t = {}
  if type(value) == 'table' then
    local i = 0
    while i < n do
      -- for i, row in pairs(tbl) do

      -- for j = 1, #value do 
      for j, _ in pairs(value) do
        -- print(j, table_to_string(value))
        if i+(j-1) < n then t[i+j] = value[j] end
      end
      i = (i + #value) or 1
    end
  else
    for i = 1, n do t[i] = value end
  end
  -- print(n, table_to_string(t))
  return t
end

-- clone a table (shallow copy)
-- @param orig table
-- @return table
function table.clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

-- split a string by a separator
-- @param str string
-- @param sep string
-- @return table
string.split = function(str, sep)
  local fields = {}
  local pattern = string.format("([^%s]+)", sep)
  str:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

--- clamp a number between a lower and upper bound (by @clem)
--- @param x number
--- @param lower_bound number
--- @param upper_bound number
--- @return number
function math.clamp(x, lower_bound, upper_bound)
    if lower_bound == nil then lower_bound = -math.huge end
    if upper_bound == nil then upper_bound = math.huge end

    if x < lower_bound then
        x = lower_bound
    end

    if x > upper_bound then
        x = upper_bound
    end

    return x
end

-- pseudo-random number generator based on a seed and a string input
-- @param seed string -- the seed for the pseudo-random number generator
-- @param str hash -- different hashes generate different numbers
-- @return number
function math.prandom(seed, str)
  -- print(str)
  local hash = love.data.hash( "sha256", seed..str )

  local hex = love.data.encode("string", "hex", hash)

  local number = tonumber(hex:sub(1,8), 16)
  -- print(number)
  return number / 4294967295 -- 2^32
end
