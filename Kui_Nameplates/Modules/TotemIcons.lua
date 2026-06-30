local addon = LibStub("AceAddon-3.0"):GetAddon("KuiNameplates")
local mod = addon:NewModule("TotemIcons", addon.Prototype, "AceEvent-3.0")

local icons = {
    ["Тотем гнева"]                  = "Interface\\Icons\\Spell_Fire_TotemOfWrath",
    ["Тотем трепета"]                = "Interface\\Icons\\Spell_Nature_TremorTotem",
    ["Тотем источника маны"]         = "Interface\\Icons\\Spell_Nature_ManaRegenTotem",
    ["Тотем гнева воздуха"]          = "Interface\\Icons\\Spell_Nature_SlowingTotem",

    ["Опаляющий тотем"]              = "Interface\\Icons\\Spell_Fire_SearingTotem",
    ["Тотем магмы"]                  = "Interface\\Icons\\Spell_Fire_SelfDestruct",

    -- ИСПРАВЛЕНО
    ["Тотем силы Земли"]              = "Interface\\Icons\\Spell_Nature_EarthBindTotem",
    ["Тотем оков земли"]             = "Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02",

    ["Тотем каменного когтя"]        = "Interface\\Icons\\Spell_Nature_StoneClawTotem",
    ["Тотем каменной кожи"]          = "Interface\\Icons\\Spell_Nature_StoneSkinTotem",

    ["Тотем элементаля земли"]       = "Interface\\Icons\\Spell_Nature_EarthElemental_Totem",
    ["Тотем элементаля огня"]        = "Interface\\Icons\\Spell_Fire_Elemental_Totem",

    -- ИСПРАВЛЕНО
    ["Тотем исцеляющего потока"]     = "Interface\\Icons\\INV_Spear_04",
    ["Тотем очищения"]               = "Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem",

    ["Тотем защиты от магии огня"]    = "Interface\\Icons\\Spell_FireResistanceTotem_01",
    ["Тотем защиты от магии природы"] = "Interface\\Icons\\Spell_Nature_NatureResistanceTotem",
    ["Тотем защиты от магии льда"]   = "Interface\\Icons\\Spell_FrostResistanceTotem_01",

    ["Тотем неистовства ветра"]      = "Interface\\Icons\\Spell_Nature_Windfury",

    -- ИСПРАВЛЕНО
    ["Тотем языка пламени"]          = "Interface\\Icons\\Spell_Nature_GuardianWard",

    ["Тотем безмятежного воздуха"]   = "Interface\\Icons\\Spell_Nature_SlowingTotem",
    ["Тотем заземления"]             = "Interface\\Icons\\Spell_Nature_GroundingTotem",
    ["Тотем стены ветра"]            = "Interface\\Icons\\Spell_Nature_InvisibilityTotem",
}
function mod:PostCreate(msg, f)
    f.totemIcon = f:CreateTexture(nil, "ARTWORK")
    f.totemIcon:SetDrawLayer("OVERLAY", 7)

    f.totemIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    f.totemIcon:SetSize(32,32)
    f.totemIcon:SetPoint("BOTTOM", f.name, "TOP", 0, 8)
    f.totemIcon:Hide()
end
function mod:Update(f)
    if not f.totemIcon then
        return
    end
local name = f.oldName and f.oldName:GetText()
if not name then
    f.totemIcon:Hide()
    return
end
-- сначала проверяем более длинное название
if name == "Тотем гнева воздуха" or name:find("^Тотем гнева воздуха ") then
    f.totemIcon:SetTexture(icons["Тотем гнева воздуха"])
    f.totemIcon:Show()
f.name:Hide()
    return
end
if name == "Тотем силы Земли" or name:find("^Тотем силы Земли ") then
    f.totemIcon:SetTexture(icons["Тотем силы Земли"])
    f.totemIcon:Show()
f.name:Hide()
    return
end
if name == "Тотем защиты от магии огня" or name:find("^Тотем защиты от магии огня ") then
    f.totemIcon:SetTexture(icons["Тотем защиты от магии огня"])
    f.totemIcon:Show()
f.name:Hide()
    return
end
if name == "Тотем защиты от магии природы" or name:find("^Тотем защиты от магии природы ") then
    f.totemIcon:SetTexture(icons["Тотем защиты от магии природы"])
    f.totemIcon:Show()
f.name:Hide()
    return
end



-- длинные названия, которые KUI обрезает

if name:find("^Тотем защиты от маг") then
    f.totemIcon:SetTexture(icons["Тотем защиты от магии льда"])
    f.totemIcon:Show()
f.name:Hide()
    return
end

if name:find("^Тотем защиты от ог") then
    f.totemIcon:SetTexture(icons["Тотем защиты от магии огня"])
    f.totemIcon:Show()
f.name:Hide()
    return
end

if name:find("^Тотем защиты от сил") then
    f.totemIcon:SetTexture(icons["Тотем защиты от магии природы"])
    f.totemIcon:Show()
f.name:Hide()
    return
end

if name:find("^Тотем силы Земли") or name:find("^Тотем силы Земли") then
    f.totemIcon:SetTexture(icons["Тотем силы Земли"])
    f.totemIcon:Show()
f.name:Hide()
    return
end
for totem, texture in pairs(icons) do
    if totem ~= "Тотем гнева воздуха" then
        if name == totem or name:find("^" .. totem .. " ") then
            f.totemIcon:SetTexture(texture)
            f.totemIcon:Show()
            f.name:Hide()
            return
        end
    end
end

f.totemIcon:Hide()
f.name:Show()
end
function mod:PostShow(msg, f)
    self:Update(f)
end

function mod:OnEnable()
    self:RegisterMessage("KuiNameplates_PostCreate", "PostCreate")
    self:RegisterMessage("KuiNameplates_PostShow", "PostShow")
end