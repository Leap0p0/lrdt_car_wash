local notif = false

local function HasEntered()
  for k, v in pairs(Config.car_wash) do
    local interval = 1
    local pos = GetEntityCoords(PlayerPedId())
    local distance = GetDistanceBetweenCoords(pos, v, true)

    if distance > 30 then
        return false
    else
        if distance < 10 then
          notif = true
          return true
          end
        end
    end
end

RegisterNetEvent('p0p0_car_wash:no_money')
AddEventHandler('p0p0_car_wash:no_money', function()
  lib.notify({
    id = 'no_money_car_wash',
    title = 'Pas assez d\'argent',
    description = 'Tu n\'as pas assez d\'argent pour utiliser le car wash !',
    position = 'top',
    style = {
        backgroundColor = '#141517',
        color = '#C1C2C5',
        ['.description'] = {
          color = '#909296'
        }
    },
    icon = 'ban',
    iconColor = '#C53030'
})
end)

RegisterNetEvent('p0p0_car_wash:go')
AddEventHandler('p0p0_car_wash:go', function(data)
  local success = lib.skillCheck('easy', {'w', 'a', 's', 'd'})
  if success == true then
    lib.notify({
      title = 'Car Wash',
      description = 'Véhicule néttoyé',
      type = 'success'
    })
    WashDecalsFromVehicle(data.entity, 1.0)
    SetVehicleDirtLevel(data.entity, 0)
  else
    lib.notify({
      id = 'no_skill_car_wash',
      title = 'Machine cassé',
      description = 'Tu as cassé la machine en voulant l\'utiliser',
      position = 'top',
      style = {
          backgroundColor = '#141517',
          color = '#C1C2C5',
          ['.description'] = {
            color = '#909296'
          }
      },
      icon = 'ban',
      iconColor = '#C53030'
  })
  end
end)

exports.ox_target:addGlobalVehicle({
  {
      name = 'wash_veh',
      icon = "fa-solid fa-cart-plus",
      label = 'Laver le véhicule ('..Config.price..'$) ',
      distance = 1.5,
      canInteract = function(entity)
          return HasEntered()
      end,
      onSelect = function(data)
        TriggerServerEvent('p0p0_car_wash:pay', Config.price, data)
      end
  }
})

Citizen.CreateThread(function()
  while true do
    if HasEntered() == true and IsPedSittingInAnyVehicle(PlayerPedId()) == 1 then
        lib.notify({
          title = 'Car Wash',
          description = 'Pour nettoyer le véhicule, pointez le avec ALT',
          type = 'inform'
        })
      Wait(30000)
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  for k,v in pairs(Config.car_wash) do
    local blips = AddBlipForCoord(v)
    SetBlipSprite(blips, Config.Blips.type)
    SetBlipDisplay(blips, 4)
    SetBlipScale(blips, Config.Blips.scale)
    SetBlipColour(blips, Config.Blips.color)
    SetBlipAsShortRange(blips, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blips.name)
    EndTextCommandSetBlipName(blips)
  end
  end)