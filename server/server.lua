RegisterNetEvent('p0p0_car_wash:pay')
AddEventHandler('p0p0_car_wash:pay', function(price, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
    local src = source

	if money < price then
        TriggerClientEvent('p0p0_car_wash:no_money', src)
    else
        xPlayer.removeMoney(price)
        TriggerClientEvent('p0p0_car_wash:go', src, data)
    end
end)