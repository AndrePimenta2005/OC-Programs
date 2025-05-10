local component = require("component")
local string = require("string")
local sleep = require("os").sleep
local table = require("table")

local function iterador(endereco, slot)

  ::next::
  slot = tonumber(slot)
  if type(slot) == "number" then
    if slot <= 0 then
      slot = 1
    elseif slot > 0 and slot < 81 then
      slot = slot + 1
    else
      return nil
    end
  else
    slot = 1
  end

  local sucess, result
  sucess, result = xpcall(component.proxy(endereco).get, function(err)
      err = tostring(err)
      if err:find("invalid slot", 0, false) then
        return table.pack(true, nil)
      end

      return table.pack(false, err)
    end, slot)


  if sucess then
    result = result or 0
    if result ~= 0 then
      return slot, result
    else
      sleep(0)
      goto next
    end
  else
    if result[1] then
      return select(2, table.unpack(result))
    else
      error("Exception not handled: " .. result[2], 1)
    end

  end

  return iterador