local FrameworkType = Config.Framework
local ESX, QBCore

-- Autodetect if not explicitly set
if not FrameworkType then
    if GetResourceState('es_extended') == 'started' then
        FrameworkType = 'esx'
    elseif GetResourceState('qb-core') == 'started' then
        FrameworkType = 'qbcore'
    elseif GetResourceState('qbox') == 'started' then
        FrameworkType = 'qbox'
    else
        print('^1[admin_heist_menu]^7 No supported framework detected! Check config.Framework')
        return
    end
end

if FrameworkType == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif FrameworkType == 'qbcore' or FrameworkType == 'qbox' then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Helper to get a player object regardless of framework
local function GetPlayerObject(src)
    if FrameworkType == 'esx' then
        return ESX.GetPlayerFromId(src)
    else
        return QBCore.Functions.GetPlayer(src)
    end
end

-- Helper to check admin permissions
local function IsAdmin(player)
    if not player then
        return false
    end
    if FrameworkType == 'esx' then
        return player.getGroup and player.getGroup() == 'admin'
    else
        local job = player.PlayerData.job
        return job and job.name == 'admin'
    end
end

-- Helper to get a unique identifier for exports
local function GetIdentifier(player)
    if FrameworkType == 'esx' then
        return player.identifier
    else
        -- QBox uses the same citizenid as QBCore
        return player.PlayerData.citizenid
    end
end

-- Notification wrapper
local function Notify(src, msg)
    if FrameworkType == 'esx' then
        GetPlayerObject(src).showNotification(msg)
    else
        TriggerClientEvent('QBCore:Notify', src, msg)
    end
end

--[[ Perform add/remove actions ]] --
RegisterNetEvent('adminheist:performAction', function(action, targetId, amount)
    local src = source
    local admin = GetPlayerObject(src)
    local tgt = GetPlayerObject(targetId)
    if not IsAdmin(admin) or not tgt then
        return
    end

    local id = GetIdentifier(tgt)
    if action == 'addCrypto' then
        exports['lunar_heistcontracts']:addPlayerCrypto(id, amount)
        Notify(src, ('✅ Added %s crypto to %s'):format(amount, tgt.PlayerData and tgt.PlayerData.charinfo.firstname or
            tgt.getName()))
    elseif action == 'removeCrypto' then
        exports['lunar_heistcontracts']:removePlayerCrypto(id, amount)
        Notify(src, ('✅ Removed %s crypto from %s'):format(amount, tgt.PlayerData and
            tgt.PlayerData.charinfo.firstname or tgt.getName()))
    elseif action == 'addXP' then
        exports['lunar_heistcontracts']:addPlayerExperience(id, amount)
        Notify(src, ('✅ Added %s XP to %s'):format(amount, tgt.PlayerData and tgt.PlayerData.charinfo.firstname or
            tgt.getName()))
    elseif action == 'removeXP' then
        exports['lunar_heistcontracts']:removePlayerExperience(id, amount)
        Notify(src, ('✅ Removed %s XP from %s'):format(amount, tgt.PlayerData and tgt.PlayerData.charinfo.firstname or
            tgt.getName()))
    end
end)

--[[ Check crypto ]] --
RegisterNetEvent('adminheist:checkCrypto', function(targetId)
    local src = source
    local admin = GetPlayerObject(src)
    local tgt = GetPlayerObject(targetId)
    if not IsAdmin(admin) or not tgt then
        return
    end

    local crypto = exports['lunar_heistcontracts']:getPlayerCrypto(GetIdentifier(tgt))
    Notify(src,
        ('%s has %s crypto'):format(tgt.PlayerData and tgt.PlayerData.charinfo.firstname or tgt.getName(), crypto))
end)

--[[ Check XP ]] --
RegisterNetEvent('adminheist:checkXP', function(targetId)
    local src = source
    local admin = GetPlayerObject(src)
    local tgt = GetPlayerObject(targetId)
    if not IsAdmin(admin) or not tgt then
        return
    end

    local xp = exports['lunar_heistcontracts']:getPlayerExperience(GetIdentifier(tgt))
    Notify(src, ('%s has %s XP'):format(tgt.PlayerData and tgt.PlayerData.charinfo.firstname or tgt.getName(), xp))
end)
