local techStore = vector3(1135.0, -472.2, 66.6) -- Example: Digital Den Location

Citizen.CreateThread(function()
    -- Add a Blip for the store
    local blip = AddBlipForCoord(techStore)
    SetBlipSprite(blip, 606) -- Mobile phone icon
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("iAdi Digital Store")
    EndTextCommandSetBlipName(blip)

    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        if #(coords - techStore) < 2.0 then
            DrawText3Ds(techStore.x, techStore.y, techStore.z, "~g~[E]~w~ Browse Tech")
            if IsControlJustReleased(0, 38) then
                OpenTechMenu()
            end
        end
    end
end)

function OpenTechMenu()
    SendNUIMessage({
        action = "openStoreUI",
        items = {
            {id = "phone", label = "Adi-Phone Infinity", price = 1200},
            {id = "sim", label = "New SIM Card", price = 150},
            {id = "powerbank", label = "Power Bank (5000mAh)", price = 300},
            {id = "case_gold", label = "Gold Plated Case", price = 5000}
        }
    })
end
