local Games = {
    ["4529197908; 4529195149; 3431407618; 45144535987; 3095204897"] = "Isle";
    ["6750059284; 6857661020; 5400959086; 6963580446; 6749046427; 7721287262; 7286283423; 6833971410; 7266535415"] = "Task-Force";
    ["5041144419; 6939657427"] = "SCP-Roleplay"
}

for PlaceId, Load in pairs(Games) do
    if PlaceId:find(game.PlaceId) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/coolb0y08/Scripts/main/Hubs/Galaxy-Ware/Games/"..Load..".lua"))()
    end
end
