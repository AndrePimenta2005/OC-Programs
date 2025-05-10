local component = require("component")
local interface = component.proxy(component.list("me_interface"), true)
local db = component.proxy(component.list("database"), true)
local iteradorBd = require("iteradorBD")

::loop::

--local lista = interface.getItemsInNetwork()
if #(interface.getItemsInNetwork())>0 then
    for key, value in ipairs(interface.getItemsInNetwork()) do
    
    end
end