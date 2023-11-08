--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 12
    local function add_zone(entries, zone_id, name)
        local show_only_current_zone = aura_env.config["show_only_current_zone"]
        local in_zone = not show_only_current_zone or C_Map.GetBestMapForUnit("player") == zone_id
        
        if in_zone then
            for i, entry in pairs(entries) do
                if entry.id and aura_env.config["hide_" .. entry.id] or
                not entry.elite and aura_env.config["show_only_elites"] and name == "Emerald Dream Rares" then
                    entries[i] = nil
                else
                    entry.zone_id = zone_id
                end
            end

            WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
            order = order + 0.01
        end
    end

    if not aura_env.config["hide_general"] then
        add_zone(aura_env.emerald_dream, 2200, "Emerald Dream")
    end
    if not aura_env.config["hide_rares"] then
        add_zone(aura_env.emerald_dream_rares, 2200, "Emerald Dream Rares")
    end
    if not aura_env.config["hide_treasures"] then
        add_zone(aura_env.emerald_dream_treasures, 2200, "Emerald Dream Treasures")
    end
end