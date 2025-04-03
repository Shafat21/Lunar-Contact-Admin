RegisterNetEvent('adminheist:performAction', function(action, targetId, amount)
    local xAdmin = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xAdmin or not xAdmin.getGroup or xAdmin.getGroup() ~= 'admin' then return end
    if not xTarget then return end

    local identifier = xTarget.identifier

    if action == 'addCrypto' then
        exports['lunar_heistcontracts']:addPlayerCrypto(identifier, amount)
        xAdmin.showNotification(('✅ Added %s crypto to %s'):format(amount, xTarget.getName()))
    elseif action == 'removeCrypto' then
        exports['lunar_heistcontracts']:removePlayerCrypto(identifier, amount)
        xAdmin.showNotification(('✅ Removed %s crypto from %s'):format(amount, xTarget.getName()))
    elseif action == 'addXP' then
        exports['lunar_heistcontracts']:addPlayerExperience(identifier, amount)
        xAdmin.showNotification(('✅ Added %s XP to %s'):format(amount, xTarget.getName()))
    elseif action == 'removeXP' then
        exports['lunar_heistcontracts']:removePlayerExperience(identifier, amount)
        xAdmin.showNotification(('✅ Removed %s XP from %s'):format(amount, xTarget.getName()))
    end
end)

RegisterNetEvent('adminheist:checkCrypto', function(targetId)
    local xAdmin = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xAdmin or not xTarget then return end
    if xAdmin.getGroup() ~= 'admin' then return end

    local crypto = exports['lunar_heistcontracts']:getPlayerCrypto(xTarget.identifier)
    xAdmin.showNotification(('%s has %s crypto'):format(xTarget.getName(), crypto))
end)

RegisterNetEvent('adminheist:checkXP', function(targetId)
    local xAdmin = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not xAdmin or not xTarget then return end
    if xAdmin.getGroup() ~= 'admin' then return end

    local xp = exports['lunar_heistcontracts']:getPlayerExperience(xTarget.identifier)
    xAdmin.showNotification(('%s has %s XP'):format(xTarget.getName(), xp))
end)
