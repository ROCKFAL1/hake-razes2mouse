local Razes2mouse = {}

local optionEnable = Menu.AddOption({"Hero Specific", "Shadow Fiend"}, "Razes to mouse", "Enable this script")

local myHero, myPlayer
local curOrder, curAbility, curOrderIssuer, curTarget
local canExecute = false
local H, H2M

function Razes2mouse.OnPrepareUnitOrders(orders)
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_nevermore" then return end
	if orders.npc == myHero and orders.player == myPlayer and orders.order == 8 and (Ability.GetName(orders.ability) == "nevermore_shadowraze1"
	or Ability.GetName(orders.ability) == "nevermore_shadowraze2" or Ability.GetName(orders.ability) == "nevermore_shadowraze3") then
		curOrder = orders.order
		curAbility = orders.ability
		curOrderIssuer = orders.orderIssuer
		curTarget = orders.target
		if Razes2mouse.OnUpdate() == false then
			Player.PrepareUnitOrders(myPlayer, 28, nil, Input.GetWorldCursorPos(), nil, 3, myHero, false, false)
		end
		Player.PrepareUnitOrders(myPlayer, curOrder, curTarget, Vector(0, 0, 0), curAbility, curOrderIssuer, myHero, false, false)	  
		Player.PrepareUnitOrders(myPlayer, 22, z, Vector(0, 0, 0), nil, 3, myHero, false, false)
		curAbility = nil
		curOrderIssuer = nil
		curTarget = nil
		return false		
	end	
end

function Razes2mouse.OnUpdate()
	if not Menu.IsEnabled(optionEnable) then return end
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_nevermore" then return end
	H = (Entity.GetAbsRotation(myHero):GetYaw())
	if Input.GetWorldCursorPos():GetX() > Entity.GetOrigin(myHero):GetX() then
		H2M = math.deg(math.atan((Input.GetWorldCursorPos():GetY()-Entity.GetOrigin(myHero):GetY())/(Input.GetWorldCursorPos():GetX()-Entity.GetOrigin(myHero):GetX())))
	end
	if Input.GetWorldCursorPos():GetX() < Entity.GetOrigin(myHero):GetX() then
		H2M = 180 + math.deg(math.atan((Input.GetWorldCursorPos():GetY()-Entity.GetOrigin(myHero):GetY())/(Input.GetWorldCursorPos():GetX()-Entity.GetOrigin(myHero):GetX())))
	end
	if Input.GetWorldCursorPos():GetX() < Entity.GetOrigin(myHero):GetX() and Input.GetWorldCursorPos():GetY() < Entity.GetOrigin(myHero):GetY() then
		H2M = math.deg(math.atan((Input.GetWorldCursorPos():GetY()-Entity.GetOrigin(myHero):GetY())/(Input.GetWorldCursorPos():GetX()-Entity.GetOrigin(myHero):GetX()))) - 180
    end
    if H2M - 7.5 < H and H2M + 7.5 > H then
        return true
    end
    return false
end

return Razes2mouse
	



