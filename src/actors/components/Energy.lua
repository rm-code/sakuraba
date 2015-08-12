local Constants = require('src.constants.Constants');

local ENERGY_THRESHOLD = Constants.ENERGY_THRESHOLD;

local Energy = {};

function Energy.new(energyDelta)
    local self = {};

    local energyDelta = energyDelta;
    local energy = energyDelta;

    function self:grantEnergy()
        energy = energy + energyDelta;
    end

    function self:drainEnergy()
        energy = energy - ENERGY_THRESHOLD;
    end

    function self:canPerform()
        return energy >= ENERGY_THRESHOLD;
    end

    function self:getEnergy()
        return energy;
    end

    return self;
end

return Energy;
