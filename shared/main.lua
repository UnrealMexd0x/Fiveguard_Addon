-- V1.4.2 Author UnrealMexd0x

local FiveguardAddon = FiveguardAddon or {}
FiveguardAddon.Shared = {}

FiveguardAddon.Shared.Search = function(s, pattern, init, plain)
    return s:find(pattern, init or 1, plain)
end

FiveguardAddon.Shared.Find = function(formatString, ...)
    local args = {...}
    return (formatString:gsub('%%(.)', function(formatChar)
        if formatChar == 's' then
            return tostring(table.remove(args, 1))
        else
            return "%" .. formatChar
        end
    end))
end

return FiveguardAddon.Shared
