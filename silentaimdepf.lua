-- options
local fov = fov or 180;
local hitPart = hitPart or "head";
local headChance = headChance or 0.5;
local randomization = randomization or 0;
local visibleCheck = visibleCheck or false;

-- variables
local localPlayer = game:GetService("Players").LocalPlayer;
local camera = game:GetService("Workspace").CurrentCamera;

-- modules
local newParticle, solveQuartic, entryTable;
for _, object in ipairs(getgc()) do
    local source, name = debug.info(object, "sn");
    source = string.match(source, "%w+$");

    if name == "new" and source == "particle" then
        newParticle = object;
    elseif name == "solve" and source == "physics" then
        solveQuartic = object;
    elseif name == "getEntry" and source == "ReplicationInterface" then
        entryTable = debug.getupvalue(object, 1);
    end

    if newParticle and solveQuartic and entryTable then
        break;
    end
end

-- functions
local function getClosest(origin, direction, ignoreList)
    local _angle = fov;
    local _vector, _entry;
    for player, entry in pairs(entryTable) do
        if player.Team == localPlayer.Team or not entry._alive then
            continue;
        end

        local name = hitPart == "random" and (math.random() < headChance and "head" or "torso") or hitPart;
        local part = assert(entry._thirdPersonObject._characterHash[name], "Unable to find hit part.");
        local position = part.Position + part.Size * 0.5 * (math.random() * 2 - 1) * randomization;
        if not visibleCheck or #camera:GetPartsObscuringTarget({ position }, ignoreList) == 0 then
            local vector = position - origin;
            local angle = math.deg(math.acos(direction:Dot(vector.Unit)));
            if angle < _angle then
                _angle = angle;
                _vector = vector;
                _entry = entry;
            end
        end
    end
    return _vector, _entry;
end

local function getTrajectory(vector, velocity, gravity, speed)
    local r1, r2, r3, r4 = solveQuartic(
        gravity:Dot(gravity) * 0.25,
        gravity:Dot(velocity),
        gravity:Dot(vector) + velocity:Dot(velocity) - speed^2,
        vector:Dot(velocity) * 2,
        vector:Dot(vector));

    local time = (r1>0 and r1) or (r2>0 and r2) or (r3>0 and r3) or r4;
    local bullet = (vector + velocity*time + 0.5*gravity*time^2) / time;
    return bullet, time;
end

-- hooks
local old;
old = hookfunction(newParticle, function(args)
    if debug.info(2, "n") == "fireRound" then
        local vector, entry = getClosest(args.position, args.velocity.Unit, args.physicsignore);
        if vector and entry then
            local index = table.find(debug.getstack(2), args.velocity);
            local velocity = getTrajectory(vector, entry._velspring.t, -args.acceleration, args.velocity.Magnitude);

            args.velocity = velocity;
            debug.setstack(2, index, velocity);
        end
    end
    return old(args);
end);
