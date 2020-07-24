local effect_list={
	EFFECT_CANNOT_TO_DECK,
	EFFECT_CANNOT_TO_GRAVE,
	EFFECT_CANNOT_TO_HAND,
	EFFECT_CANNOT_REMOVE,
	EFFECT_CANNOT_TRIGGER,
	EFFECT_CANNOT_SUMMON,
	EFFECT_CANNOT_SPECIAL_SUMMON,
	EFFECT_CANNOT_SUMMON,
	EFFECT_CANNOT_MSET,
	EFFECT_CANNOT_SSET,
	EFFECT_IMMUNE_EFFECT,
	EFFECT_CANNOT_CHANGE_CONTROL,
}
local function f(e,p,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(p,LOCATION_ONFIELD,0)
	local ct=g:GetCount()-ct[p]
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local sg=g:Select(p,ct,ct,nil)
	Duel.SendtoDeck(sg,nil,1,REASON_RULE)
	for tc in aux.Next(sg) do for i,v in ipairs(effect_list) do
		local e1=Effect.GlobalEffect()
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(v)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetTargetRange(0xff,0)
		e1:SetTarget(function(ef,c) return c==tc end)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(aux.TRUE)
		Duel.RegisterEffect(e1,p)
	end end
end
ct={1}
ct[0]=1
local p0=Effect.GlobalEffect()
p0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
p0:SetCode(EVENT_PHASE_START+PHASE_DRAW)
p0:SetCondition(function(e,p) return Duel.GetTurnPlayer()==p end)
p0:SetOperation(function(e,tp)
	local p=Duel.GetTurnPlayer()
	ct[p]=ct[p]+1
	if Duel.GetTurnCount()~=1 then return end
	while Duel.GetFieldGroupCount(p,LOCATION_HAND,0)>1 and Duel.SelectYesNo(p,1108) do
		local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
		Duel.SendtoDeck(g,nil,2,REASON_RULE)
		Duel.ShuffleDeck(p)
		Duel.Draw(p,g:GetCount(),REASON_RULE)
		Duel.SendtoDeck(Duel.GetFieldGroup(p,LOCATION_HAND,0):Select(p,1,1,nil),nil,2,REASON_RULE)
	end
	while Duel.GetFieldGroupCount(1-p,LOCATION_HAND,0)>1 and Duel.SelectYesNo(1-p,1108) do
		local g=Duel.GetFieldGroup(1-p,LOCATION_HAND,0)
		Duel.SendtoDeck(g,nil,2,REASON_RULE)
		Duel.ShuffleDeck(1-p)
		Duel.Draw(1-p,g:GetCount(),REASON_RULE)
		Duel.SendtoDeck(Duel.GetFieldGroup(1-p,LOCATION_HAND,0):Select(1-p,1,1,nil),nil,2,REASON_RULE)
	end
end)
Duel.RegisterEffect(p0,0)
local p1=Effect.GlobalEffect()
p1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
p1:SetCode(EVENT_PHASE+PHASE_DRAW)
p1:SetCountLimit(1)
p1:SetCondition(function(e,p) return Duel.GetTurnPlayer()==p end)
p1:SetOperation(f)
Duel.RegisterEffect(p1,0)
local p2=p1:Clone()
p2:SetCode(EVENT_PHASE+PHASE_STANDBY)
Duel.RegisterEffect(p2,0)
local p3=p1:Clone()
p3:SetCode(EVENT_PHASE_START+PHASE_BATTLE_START)
Duel.RegisterEffect(p3,0)
local p4=p1:Clone()
p4:SetCode(EVENT_PHASE+PHASE_BATTLE)
Duel.RegisterEffect(p4,0)
local p5=p1:Clone()
p5:SetCode(EVENT_PHASE_START+PHASE_END)
Duel.RegisterEffect(p5,0)
local p6=p1:Clone()
p6:SetCode(EVENT_PHASE+PHASE_END)
Duel.RegisterEffect(p6,0)
local o0=p0:Clone()
Duel.RegisterEffect(o0,1)
local o1=p1:Clone()
Duel.RegisterEffect(o1,1)
local o2=p2:Clone()
Duel.RegisterEffect(o2,1)
local o3=p3:Clone()
Duel.RegisterEffect(o3,1)
local o4=p4:Clone()
Duel.RegisterEffect(o4,1)
local o5=p5:Clone()
Duel.RegisterEffect(o5,1)
local o6=p6:Clone()
Duel.RegisterEffect(o6,1)