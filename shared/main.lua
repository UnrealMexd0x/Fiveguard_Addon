FiveguardAddon = FiveguardAddon or {}
FiveguardAddon.Shared = {}

FiveguardAddon.Shared.Search = function(s, pattern, init, plain)
    return s:find(pattern, init or 1, plain)
end

return FiveguardAddon.Shared