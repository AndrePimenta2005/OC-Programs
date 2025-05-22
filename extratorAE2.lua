local component = require("component")
local interface = component.proxy(component.list("me_interface"), true)
local db = component.proxy(component.list("database"), true)
local iteradorBd = require("iteradorBD")

::loop::
do
    --local lista = interface.getItemsInNetwork()

    for i=1, 9 do
        local tempItem = interface.getItemsInNetwork()[i]
        interface.store(tempItem, db.address, i)
        interface.setInterfaceConfiguration(i, database.address, i, tempItem.maxSize)
        db.clear(i)
    end

end
goto loop;