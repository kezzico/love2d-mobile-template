local function eval_units(value_plus_unit, relative_to)
  local r = value_plus_unit

  if type(r) == "string" and (r:find("[+-]", 2)) then
    local val1, val2 = r:match("^([^+-]+)([+-].+)$")

    local a = eval_units(val1, relative_to)
    local b = eval_units(val2, relative_to)
    
    return a + b
  end

  if type(r) == "string" and r:sub(-1) == "%" then
    r = tonumber(r:sub(1, -2)) * relative_to / 100
  elseif type(r) == "string" and r:sub(-2) == "px" then
    r = tonumber(r:sub(1, -3))
  elseif type(r) == "string" then
    r = tonumber(r)
  end

  return r
end

return eval_units
