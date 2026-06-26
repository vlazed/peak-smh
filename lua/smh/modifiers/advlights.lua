-- Backwards compat
include("sent.lua")
MOD.Name = "Advanced Lights (deprecated)";

local validClasses = {
    projected_light = true,
    projected_light_new = true,
    cheap_light = true,
    expensive_light = true,
    expensive_light_new = true,
    spot_light = true
};

function MOD:IsAdvLight(entity)

    local theclass = entity:GetClass();

    return validClasses[theclass] or false;

end

function MOD:IsProjectedLight(entity)

    local theclass = entity:GetClass();

    if theclass == "cheap_light" or theclass == "spot_light" then return false; end
    return true;

end

function MOD:Load(entity, data)

    if not self:IsAdvLight(entity) then return; end -- can never be too sure?

    entity:SetBrightness(data.Brightness);
    entity:SetLightColor(data.Color or data.LightColor);

    if self:IsProjectedLight(entity) then
        local theclass = entity:GetClass();
        if theclass ~= "expensive_light" and theclass ~= "expensive_light_new" then
            entity:SetLightFOV(data.FOV or data.LightFOV);
        end
        if theclass == "projected_light_new" then
            entity:SetOrthoBottom(data.OrthoBottom);
            entity:SetOrthoLeft(data.OrthoLeft);
            entity:SetOrthoRight(data.OrthoRight);
            entity:SetOrthoTop(data.OrthoTop);
        end
        entity:SetNearZ(data.Nearz or data.NearZ);
        entity:SetFarZ(data.Farz or data.FarZ);
    elseif entity:GetClass() == "cheap_light" then
        entity:SetLightSize(data.LightSize);
    else
        entity:SetInnerFOV(data.InFOV or data.InnerFOV);
        entity:SetOuterFOV(data.OutFOV or data.OuterFOV);
        entity:SetRadius(data.Radius);
    end

end

function MOD:LoadBetween(entity, data1, data2, percentage)

    if not self:IsAdvLight(entity) then return; end -- can never be too sure?

    entity:SetBrightness(SMH.LerpLinear(data1.Brightness, data2.Brightness, percentage));
    entity:SetLightColor(SMH.LerpLinearVector(data1.Color or data1.LightColor, data2.Color or data2.LightColor, percentage));

    if self:IsProjectedLight(entity) then
        local theclass = entity:GetClass();
        if theclass ~= "expensive_light" and theclass ~= "expensive_light_new" then
            entity:SetLightFOV(SMH.LerpLinear(data1.FOV or data1.LightFOV, data2.FOV or data2.LightFOV, percentage));
        end
        if theclass == "projected_light_new" then
            entity:SetOrthoBottom(SMH.LerpLinear(data1.OrthoBottom, data2.OrthoBottom, percentage));
            entity:SetOrthoLeft(SMH.LerpLinear(data1.OrthoLeft, data2.OrthoLeft, percentage));
            entity:SetOrthoRight(SMH.LerpLinear(data1.OrthoRight, data2.OrthoRight, percentage));
            entity:SetOrthoTop(SMH.LerpLinear(data1.OrthoTop, data2.OrthoTop, percentage));
        end
        entity:SetNearZ(SMH.LerpLinear(data1.Nearz or data1.NearZ, data2.Nearz or data2.NearZ, percentage));
        entity:SetFarZ(SMH.LerpLinear(data1.Farz or data1.FarZ, data2.Farz or data2.FarZ, percentage));
    elseif entity:GetClass() == "cheap_light" then
        entity:SetLightSize(SMH.LerpLinear(data1.LightSize, data2.LightSize, percentage));
    else
        entity:SetInnerFOV(SMH.LerpLinear(data1.InFOV or data1.InnerFOV, data2.InFOV or data2.InnerFOV, percentage));
        entity:SetOuterFOV(SMH.LerpLinear(data1.OutFOV or data1.OuterFOV, data2.OutFOV or data2.OuterFOV, percentage));
        entity:SetRadius(SMH.LerpLinear(data1.Radius, data2.Radius, percentage));
    end

end
