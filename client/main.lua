FiveguardAddon = FiveguardAddon or {}
FiveguardAddon.Client = {
    playerLoaded = false,
    resourceWhitelist = {}
}

FiveguardAddon.CreateThread(function()
    FiveguardAddon.Client.playerLoaded = true
end)

FiveguardAddon.Client.checkWhitelist = function(resource)
    return not FiveguardAddon.Client.playerLoaded or FiveguardAddon.Client.resourceWhitelist[resource]
end

FiveguardAddon.Client.addWhitelist = function(resource)
    FiveguardAddon.Client.resourceWhitelist[resource] = true
end

FiveguardAddon.Client.removeWhitelist = function(resource)
    FiveguardAddon.Client.resourceWhitelist[resource] = nil
end

FiveguardAddon.Client.ClientStop = function(resource)
    if not FiveguardAddon.Client.checkWhitelist(resource) then
        TriggerServerEvent("Fiveguard_Addon:BanPlayerStop", resource)
    end

    FiveguardAddon.Client.removeWhitelist(resource)
end

FiveguardAddon.Client.Stop = function(resource)
    if GetInvokingResource() ~= nil then return end
    FiveguardAddon.Client.addWhitelist(resource)
end

FiveguardAddon.AddEvent("onClientResourceStop", FiveguardAddon.Client.ClientStop)
FiveguardAddon.AddEvent("onResourceStop", FiveguardAddon.Client.Stop)
