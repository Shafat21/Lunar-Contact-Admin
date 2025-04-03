RegisterCommand('adminheist', function()
    local playerList = {}
    for _, playerId in ipairs(GetActivePlayers()) do
        local serverId = GetPlayerServerId(playerId)
        local name = GetPlayerName(playerId)
        table.insert(playerList, {
            title = name .. ' (' .. serverId .. ')',
            description = 'Click to manage',
            icon = 'user',
            serverId = serverId,
            onSelect = function()
                openHeistOptionsMenu(serverId)
            end
        })
    end

    lib.registerContext({
        id = 'admin_heist_players',
        title = 'Heist Admin Panel',
        options = playerList
    })

    lib.showContext('admin_heist_players')
end)

function openHeistOptionsMenu(targetId)
    lib.registerContext({
        id = 'admin_heist_actions',
        title = 'Manage Player (' .. targetId .. ')',
        menu = 'admin_heist_players',
        options = {
            {
                title = '➕ Add Crypto',
                onSelect = function()
                    inputHeistAmount('addCrypto', targetId)
                end
            },
            {
                title = '➖ Remove Crypto',
                onSelect = function()
                    inputHeistAmount('removeCrypto', targetId)
                end
            },
            {
                title = '📈 Add Experience',
                onSelect = function()
                    inputHeistAmount('addXP', targetId)
                end
            },
            {
                title = '📉 Remove Experience',
                onSelect = function()
                    inputHeistAmount('removeXP', targetId)
                end
            },
            {
                title = '🔍 Check Crypto',
                onSelect = function()
                    TriggerServerEvent('adminheist:checkCrypto', targetId)
                end
            },
            {
                title = '🔍 Check Experience',
                onSelect = function()
                    TriggerServerEvent('adminheist:checkXP', targetId)
                end
            }
        }
    })

    lib.showContext('admin_heist_actions')
end

function inputHeistAmount(action, targetId)
    local input = lib.inputDialog('Enter Amount', {
        {type = 'number', label = 'Amount', placeholder = '100'}
    })

    if not input then return end

    TriggerServerEvent('adminheist:performAction', action, targetId, tonumber(input[1]))
end
