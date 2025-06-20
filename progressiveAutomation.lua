local transposer = require("component").transposer
local sides = require("sides")
local sideWheat = sides.east
local sideSeed = sides.up
local sidePlanter = sides.north
local auxInv = sides.down
local sideCharger = sides.west
local sleep = require("os").sleep
local string = require("string")

::redo::
do
  local seedsReserve = 0
  for i = 5, 13 do
    local item = transposer.getStackInSlot(sidePlanter, i)
    if item then
      local idItem = item.name:match(":(.*)")
      if idItem == "wheat" then
        transposer.transferItem(sidePlanter, sideWheat, item.qty, i, 1)
      elseif idItem == "wheat_seeds" then
        if seedsReserve == 0 then
          seedsReserve = 1
        else
          transposer.transferItem(sidePlanter, sideSeed, item.qty, i, 1)
        end
      end
    end
  end
  local seedsPlant = transposer.getSlotStackSize(sidePlanter, 2)
  if (seedsPlant == 0) and (seedsReserve == 0) then
    transposer.transferItem(sideSeed, sidePlanter, 1, 2, 2)
  end
end

do
  local availableHoe = transposer.getStackInSlot(sidePlanter, 2)
  local pos
  if availableHoe then
    if availableHoe.dmg <= ((availableHoe.maxDamage * 15)/100) then
      for i=1, 32 do
        local item = transposer.getStackInSlot(sideCharger, i)
        if item then
          if item.dmg >= ((item.maxDamage * 60)/100) then
            pos = i
            break
          end
        end
      end
      if pos then
        transposer.transferItem(sidePlanter, auxInv, 1, 2, 1)
        transposer.transferItem(sideCharger, sidePlanter, 1, pos, 3)
        transposer.transferItem(auxInv, sideCharger, 1, 1, 1)
      end
    end
  end
end

sleep(0)
goto redo
