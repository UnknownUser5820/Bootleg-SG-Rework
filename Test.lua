-- This script has been converted to FE by jh0nd0eone
--wait(3)
if script.Parent == game:GetService("StarterGui") then script.Disabled=true;return;end
local Player,Mouse,mouse,UserInputService,ContextActionService = owner,nil,nil,nil,nil
Player.Character.Archivable = true
local Char = Player.Character:Clone()
Player.Character.Archivable = false
Char.Parent = workspace
Char.HumanoidRootPart.Anchored = true
Char:MoveTo(Player.Character.HumanoidRootPart.Position + Vector3.new(0,6,0))
Player.Character.Parent = nil
Player.Character = Char
Char.HumanoidRootPart.Anchored = false
do
	local GUID = {}
	do
		GUID.IDs = {};
		function GUID:new(len)
			local id;
			if(not len)then
				id = (tostring(function() end))
				id = id:gsub("function: ","")
			else
				local function genID(len)
					local newID = ""
					for i = 1,len do
						newID = newID..string.char(math.random(48,90))
					end
					return newID
				end
				repeat id = genID(len) until not GUID.IDs[id]
				local oid = id;
				id = {Trash=function() GUID.IDs[oid]=nil; end;Get=function() return oid; end}
				GUID.IDs[oid]=true;
			end
			return id
		end
	end

	local AHB = Instance.new("BindableEvent")

	local FPS = 30

	local TimeFrame = 0

	local LastFrame = tick()
	local Frame = 1/FPS

	game:service'RunService'.Heartbeat:connect(function(s,p)
		TimeFrame = TimeFrame + s
		if(TimeFrame >= Frame)then
			for i = 1,math.floor(TimeFrame/Frame) do
				AHB:Fire()
			end
			LastFrame=tick()
			TimeFrame=TimeFrame-Frame*math.floor(TimeFrame/Frame)
		end
	end)


	function swait(dur)
		if(dur == 0 or typeof(dur) ~= 'number')then
			AHB.Event:wait()
		else
			for i = 1, dur*FPS do
				AHB.Event:wait()
			end
		end
	end
	local Swait = swait

	local loudnesses={}
	local CoAS = {Actions={}}
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInputEvent"
	local Func = Instance.new("RemoteFunction")
	Func.Name = "GetClientProperty"
	Func.Parent = Player.Character
	local fakeEvent = function()
		local t = {_fakeEvent=true,Waited={}}
		t.Connect = function(self,f)
			local ft={Disconnected=false;disconnect=function(s) s.Disconnected=true end}
			ft.Disconnect=ft.disconnect

			ft.Func=function(...)
				for id,_ in next, t.Waited do 
					t.Waited[id] = true 
				end 
				return f(...)
			end; 
			self.Function=ft;
			return ft;
		end
		t.connect = t.Connect
		t.Wait = function() 
			local guid = GUID:new(25)
			local waitingId = guid:Get()
			t.Waited[waitingId]=false
			repeat swait() until t.Waited[waitingId]==true  
			t.Waited[waitingId]=nil;
			guid:Trash()
		end
		t.wait = t.Wait
		return t
	end
	Create = function(Obj)
		local Ins = Instance.new(Obj);
		return function(Property)
			if Property then else return Ins end
			for Property_,Value_ in next, Property do
				Ins[Property_] = Value_;
			end;
			return Ins;
		end;
	end;
	--[[NLS = function(sourcevalue, parent)
		-- New Local Script
		local NS = require(6084597954):Clone();
		NS.Name = "NLS";
		NS.code.Value = sourcevalue;
		NS.Parent = parent;
		wait(0.3);
		NS.Disabled = false;
		return NS;
	end;]]
	Coroutine_ = function(func)
		return coroutine.resume(coroutine.create(func));
	end;
	local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
	local UsIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}

	function CoAS:BindAction(name,fun,touch,...)
		CoAS.Actions[name] = {Name=name,Function=fun,Keys={...}}
	end
	function CoAS:UnbindAction(name)
		CoAS.Actions[name] = nil
	end
	local function te(self,ev,...)
		local t = self[ev]
		if t and t._fakeEvent and t.Function and t.Function.Func and not t.Function.Disconnected then
			t.Function.Func(...)
		elseif t and t._fakeEvent and t.Function and t.Function.Func and t.Function.Disconnected then
			self[ev].Function=nil
		end
	end
	m.TrigEvent = te
	UsIS.TrigEvent = te
	Event.OnServerEvent:Connect(function(plr,io)
		if plr~=Player then return end
		if io.Mouse then
			m.Target = io.Target
			m.Hit = io.Hit
		elseif io.KeyEvent then
			m:TrigEvent('Key'..io.KeyEvent,io.Key)
		elseif io.UserInputType == Enum.UserInputType.MouseButton1 then
			if io.UserInputState == Enum.UserInputState.Begin then
				m:TrigEvent("Button1Down")
			else
				m:TrigEvent("Button1Up")
			end
		end
		if(not io.KeyEvent and not io.Mouse)then
			for n,t in pairs(CoAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			if io.UserInputState == Enum.UserInputState.Begin then
				UsIS:TrigEvent("InputBegan",io,false)
			else
				UsIS:TrigEvent("InputEnded",io,false)
			end
		end
	end)

	Func.OnServerInvoke = function(plr,inst,play)
		if plr~=Player then return end
		if(inst and typeof(inst) == 'Instance' and inst:IsA'Sound')then
			loudnesses[inst]=play	
		end
	end

	function GetClientProperty(inst,prop)
		if(prop == 'PlaybackLoudness' and loudnesses[inst])then 
			return loudnesses[inst] 
		elseif(prop == 'PlaybackLoudness')then
			return Func:InvokeClient(Player,'RegSound',inst)
		end
		return Func:InvokeClient(Player,inst,prop)
	end
	Event.Parent = NLS([==[
	
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "jh0n's R15 Template";
		Text = "???";
		Duration = 30;
		Button1 = "Ok";
	})
	local me = game:service'Players'.localPlayer;
	local mouse = me:GetMouse();
	local UIS = game:service'UserInputService'
	local ch = me.Character;
    workspace.CurrentCamera.CameraSubject = me.Character
    
	--[[game:GetService("RunService").RenderStepped:Connect(function()
		local off = ch:WaitForChild("Head").CFrame:toObjectSpace(ch:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0,1.5,0))
		ch:WaitForChild("Humanoid").CameraOffset = ch:WaitForChild("Humanoid").CameraOffset:Lerp(Vector3.new(off.x,-off.y,-off.z),.1)
	end)]]
    
	local UserEvent = script:WaitForChild('UserInputEvent',30)

	UIS.InputChanged:connect(function(io,gpe)
		if(io.UserInputType == Enum.UserInputType.MouseMovement)then
			UserEvent:FireServer{Mouse=true,Target=mouse.Target,Hit=mouse.Hit}
		end
	end)

	mouse.Changed:connect(function(o)
		if(o == 'Target' or o == 'Hit')then
			UserEvent:FireServer{Mouse=true,Target=mouse.Target,Hit=mouse.Hit}
		end
	end)

	UIS.InputBegan:connect(function(io,gpe)
		if(gpe)then return end
		UserEvent:FireServer{InputObject=true,KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
	end)

	UIS.InputEnded:connect(function(io,gpe)
		if(gpe)then return end
		UserEvent:FireServer{InputObject=true,KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState}
	end)

	mouse.KeyDown:connect(function(k)
		UserEvent:FireServer{KeyEvent='Down',Key=k}
	end)

	mouse.KeyUp:connect(function(k)
		UserEvent:FireServer{KeyEvent='Up',Key=k}
	end)

	local ClientProp = ch:WaitForChild('GetClientProperty',30)

	local sounds = {}


	function regSound(o)
		if(o:IsA'Sound')then
		
			local lastLoudness = o.PlaybackLoudness
			ClientProp:InvokeServer(o,lastLoudness)
			table.insert(sounds,{o,lastLoudness})
		end
	end

	ClientProp.OnClientInvoke = function(inst,prop)
		if(inst == 'RegSound')then
			regSound(prop)
			for i = 1, #sounds do
				 if(sounds[i][1] == prop)then 
					return sounds[i][2]
				end 
			end 
		else
			return inst[prop]
		end
	end

	for _,v in next, workspace:GetDescendants() do regSound(v) end
	workspace.DescendantAdded:connect(regSound)
	me.Character.DescendantAdded:connect(regSound)

	game:service'RunService'.RenderStepped:connect(function()
		for i = 1, #sounds do
			local tab = sounds[i]
			local object,last=unpack(tab)
			if(object.PlaybackLoudness ~= last)then
				sounds[i][2]=object.PlaybackLoudness
				ClientProp:InvokeServer(object,sounds[i][2])
			end
		end
	end)
]==],Player.Character)
	Mouse, mouse, UserInputService, ContextActionService = m, m, UsIS, CoAS
end

-- Template Build: 7:13 PM, 9/28/2020
-- Made by jh0nd0eone
-- <Script Name> made by <person who made it>
-- Some Sources and functionality might be stolen from other scripts, i do not take credit for them.

PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Torso = Character["UpperTorso"]
Head = Character.Head
RightArm = Character["RightHand"]
LeftArm = Character["LeftHand"]
RightLeg = Character["RightUpperLeg"]
LeftLeg = Character["LeftUpperLeg"]
Humanoid = Character.Humanoid
LeftFoot = Character["LeftFoot"]
LeftHand = Character["LeftHand"]
LeftLowerArm = Character["LeftLowerArm"]
LeftLowerLeg = Character["LeftLowerLeg"]
LeftUpperArm = Character["LeftUpperArm"]
LeftUpperLeg = Character["LeftUpperLeg"]
LowerTorso = Character["LowerTorso"]
RightFoot = Character["RightFoot"]
RightHand = Character["RightHand"]
RightLowerArm = Character["RightLowerArm"]
RightLowerLeg = Character["RightLowerLeg"]
RightUpperArm = Character["RightUpperArm"]
RightUpperLeg = Character["RightUpperLeg"]
UpperTorso = Character["UpperTorso"]
RootPart = Character["HumanoidRootPart"]
Neck = Head.Neck
Waist = UpperTorso["Waist"]
RightHip = RightUpperLeg["RightHip"]
RightShoulder = RightUpperArm["RightShoulder"]
RightKnee = RightLowerLeg["RightKnee"]
RightElbow = RightLowerArm["RightElbow"]
RightWrist = RightHand["RightWrist"]
RightAnkle = RightFoot["RightAnkle"]
Root = LowerTorso["Root"]
LeftHip = LeftUpperLeg["LeftHip"]
LeftShoulder = LeftUpperArm["LeftShoulder"]
LeftKnee = LeftLowerLeg["LeftKnee"]
LeftElbow = LeftLowerArm["LeftElbow"]
LeftWrist = LeftHand["LeftWrist"]
LeftAnkle = LeftFoot["LeftAnkle"]
---
LeftAnkleC0 = LeftAnkle.C0
LeftElbowC0 = LeftElbow.C0
LeftWristC0 = LeftWrist.C0
LeftKneeC0 = LeftKnee.C0
LeftShoulderC0 = LeftShoulder.C0
LeftHipC0 = LeftHip.C0
RootC0 = Root.C0
RightAnkleC0 = RightAnkle.C0
RightWristC0 = RightWrist.C0
RightElbowC0 = RightElbow.C0
RightKneeC0 = RightKnee.C0
RightShoulderC0 = RightShoulder.C0
RightHipC0 = RightHip.C0
WaistC0 = Waist.C0
NeckC0 = Neck.C0
pcall(function()
	local ANIMATOR = Humanoid.Animator
	local ANIMATE = Character.Animate
	for i,v in pairs(ANIMATE:GetDescendants())do
		if v:IsA("Animation") then
			v.Animation = ""
		end
	end
	for _,v in next,Humanoid:GetPlayingAnimationTracks() do v:Stop();end;
	Humanoid.Jump = true
	wait(0.1)
	ANIMATE:Destroy()
end)

--Shortcuts
Inst = Instance.new
Cf = CFrame.new
Vt = Vector3.new
Rad = math.rad
C3 = Color3.new
UD2 = UDim2.new
BrickC = BrickColor.new
Angles = CFrame.Angles
Euler = CFrame.fromEulerAnglesXYZ
Cos = math.cos
ACos = math.acos
Sin = math.sin
ASin = math.asin
ABS = math.abs
MRandom = math.random
Floor = math.floor
Clamp = math.clamp


function NewAnim(data,Type)
	local RootJointT = data.RootJointDelay
	local WaistT = data.WaistDelay
	local NeckT = data.NeckDelay
	local LeftShoulderT = data.LeftShoulderDelay
	local LeftElbowT = data.LeftElbowDelay
	local LeftWristT = data.LeftWristDelay
	local RightShoulderT = data.RightShoulderDelay
	local RightElbowT = data.RightElbowDelay
	local RightWristT = data.RightWristDelay
	local LeftHipT = data.LeftHipDelay
	local LeftAnkleT = data.LeftAnkleDelay
	local LeftKneeT = data.LeftKneeDelay
	local RightHipT = data.RightHipDelay
	local RightAnkleT = data.RightAnkleDelay
	local RightKneeT = data.RightKneeDelay
	local RootJCf = data.RootJoint
	local WaistCf = data.Waist
	local NeckCf = data.Neck
	local LeftShoulderCf = data.LeftShoulder
	local LeftElbowCf = data.LeftElbow
	local LeftWristCf = data.LeftWrist
	local RightShoulderCf = data.RightShoulder
	local RightElbowCf = data.RightElbow
	local RightWristCf = data.RightWrist
	local LeftHipCf = data.LeftHip
	local LeftAnkleCf = data.LeftAnkle
	local LeftKneeCf = data.LeftKnee
	local RightHipCf = data.RightHip
	local RightAnkleCf = data.RightAnkle
	local RightKneeCf = data.RightKnee
	if Type == "Tween" then
		SetTween(Root,{C0 = RootC0 * RootJCf},"Quad","Out",RootJointT)
		SetTween(Waist,{C0 = WaistC0 * WaistCf},"Quad","Out",WaistT)
		SetTween(Neck,{C0 = NeckC0 * NeckCf},"Quad","Out",NeckT)
		SetTween(LeftShoulder,{C0 = LeftShoulderC0 * LeftShoulderCf},"Quad","Out",LeftShoulderT)
		SetTween(LeftElbow,{C0 = LeftElbowC0 * LeftElbowCf},"Quad","Out",LeftElbowT)
		SetTween(LeftWrist,{C0 = LeftWristC0 * LeftWristCf},"Quad","Out",LeftWristT)
		SetTween(RightShoulder,{C0 = RightShoulderC0 * RightShoulderCf},"Quad","Out",RightShoulderT)
		SetTween(RightElbow,{C0 = RightElbowC0 * RightElbowCf},"Quad","Out",RightElbowT)
		SetTween(RightWrist,{C0 = RightWristC0 * RightWristCf},"Quad","Out",RightWristT)
		SetTween(LeftHip,{C0 = LeftHipC0 * LeftHipCf},"Quad","Out",LeftHipT)
		SetTween(LeftAnkle,{C0 = LeftAnkleC0 * LeftAnkleCf},"Quad","Out",LeftAnkleT)
		SetTween(LeftKnee,{C0 = LeftKneeC0 * LeftKneeCf},"Quad","Out",LeftKneeT)
		SetTween(RightHip,{C0 = RightHipC0 * RightHipCf},"Quad","Out",RightHipT)
		SetTween(RightAnkle,{C0 = RightAnkleC0 * RightAnkleCf},"Quad","Out",RightAnkleT)
		SetTween(RightKnee,{C0 = RightKneeC0 * RightKneeCf},"Quad","Out",RightKneeT)
	elseif Type == "Lerp" then
		Root.C0 = Root.C0:lerp(RootC0 * RootJCf,RootJointT)
		Waist.C0 = WaistC0:lerp(WaistC0 * WaistCf,WaistT)
		Neck.C0 = Neck.C0:lerp(NeckC0 * NeckCf,NeckT)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderC0 * LeftShoulderCf,LeftShoulderT)
		LeftElbow.C0 = LeftElbow.C0:lerp(LeftElbowC0 * LeftElbowCf,LeftElbowT)
		LeftWrist.C0 = LeftWrist.C0:lerp(LeftWristC0 * LeftWristCf,LeftWristT)
		RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderC0 * RightShoulderCf,RightShoulderT)
		RightElbow.C0 = RightElbow.C0:lerp(RightElbowC0 * RightElbowCf,RightElbowT)
		RightWrist.C0 = RightWrist.C0:lerp(RightWristC0 * RightWristCf,RightWristT)
		LeftHip.C0 = LeftHip.C0:lerp(LeftHipC0 * LeftHipCf,LeftHipT)
		LeftAnkle.C0 = LeftAnkle.C0:lerp(LeftAnkleC0 * LeftAnkleCf,LeftAnkleT)
		LeftKnee.C0 = LeftKnee.C0:lerp(LeftKneeC0 * LeftKneeCf,LeftKneeT)
		RightHip.C0 = RightHip.C0:lerp(RightHipC0 * RightHipCf,RightHipT)
		RightAnkle.C0 = RightAnkle.C0:lerp(RightAnkleC0 * RightAnkleCf,RightAnkleT)
		RightKnee.C0 = RightKnee.C0:lerp(RightKneeC0 * RightKneeCf,RightKneeT)
	else
		Root.C0 = Root.C0:lerp(RootC0 * RootJCf,RootJointT)
		Waist.C0 = WaistC0:lerp(WaistC0 * WaistCf,WaistT)
		Neck.C0 = Neck.C0:lerp(NeckC0 * NeckCf,NeckT)
		LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderC0 * LeftShoulderCf,LeftShoulderT)
		LeftElbow.C0 = LeftElbow.C0:lerp(LeftElbowC0 * LeftElbowCf,LeftElbowT)
		LeftWrist.C0 = LeftWrist.C0:lerp(LeftWristC0 * LeftWristCf,LeftWristT)
		RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderC0 * RightShoulderCf,RightShoulderT)
		RightElbow.C0 = RightElbow.C0:lerp(RightElbowC0 * RightElbowCf,RightElbowT)
		RightWrist.C0 = RightWrist.C0:lerp(RightWristC0 * RightWristCf,RightWristT)
		LeftHip.C0 = LeftHip.C0:lerp(LeftHipC0 * LeftHipCf,LeftHipT)
		LeftAnkle.C0 = LeftAnkle.C0:lerp(LeftAnkleC0 * LeftAnkleCf,LeftAnkleT)
		LeftKnee.C0 = LeftKnee.C0:lerp(LeftKneeC0 * LeftKneeCf,LeftKneeT)
		RightHip.C0 = RightHip.C0:lerp(RightHipC0 * RightHipCf,RightHipT)
		RightAnkle.C0 = RightAnkle.C0:lerp(RightAnkleC0 * RightAnkleCf,RightAnkleT)
		RightKnee.C0 = RightKnee.C0:lerp(RightKneeC0 * RightKneeCf,RightKneeT)
	end
end

function DoLerp(p,c2,cf,t)
	if c2 == "C0" then
		p.C0 = p.C0:lerp(cf,t)
	elseif c2 == "C1" then
		p.C1 = p.C1:lerp(cf,t)
	end
end

--Other

local Anim = "Idle"
local Effects=Instance.new("Folder",Character);Effects.Name="Effects1"
local NewAnimSpeed = 0.5
local WalkSpeedValue = 4
local Movement = 8
local Speed = 16
local Sine = 0
local Change = 1
local DamageMultiplier = 1
local Mode = 1
local Visual = 9936321839
local Volume = 3
local Pitch = 1
local Attack = false
local Rooted = false
local Hold = false
local KeyHold = false
local MSound = Inst("Sound",Torso)
local TorsoC0 = Cf(0, 0, 0) * Angles(Rad(-90), Rad(0), Rad(180))
local HeadC0 = Cf(0, 1, 0) * Angles(Rad(-90), Rad(0), Rad(180))
local RightShoulderC0 = Cf(-0.5, 0, 0) * Angles(Rad(0), Rad(90), Rad(0))
local LeftShoulderC0 = Cf(0.5, 0, 0) * Angles(Rad(0), Rad(-90), Rad(0))
local RightHipC0 = Cf(1, -1, -0.01) * Angles(Rad(0), Rad(90), Rad(0))
local LeftHipC0 = Cf(-1, -1, -0.01) * Angles(Rad(0), Rad(-90), Rad(0))

--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")
Frame_Speed = 0.016666666666666666
Frame_Speed = 1 / 80 -- (1 / 60) OR (1 / 80)
frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

--//=================================\\
--\\=================================//
function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

--//---------------------------------------\\--
--|              Functions                  |--
--\\---------------------------------------//--

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = Inst(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or Vt(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = Inst("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BrickC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end


function Clerp(a,b,t) 
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)} 
	local ax, ay, az = a.x, a.y, a.z 
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1-t
	return QuaternionToCFrame(_t*ax + t*bx, _t*ay + t*by, _t*az + t*bz,QuaternionSlerp(qa, qb, t)) 
end 

function aclerp(startCF,endCF,alpha)
	return startCF:lerp(endCF, alpha)
end

function QuaternionFromCFrame(cf) 
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components() 
	local trace = m00 + m11 + m22 
	if trace > 0 then 
		local s = math.sqrt(1 + trace) 
		local recip = 0.5/s 
		return (m21-m12)*recip, (m02-m20)*recip, (m10-m01)*recip, s*0.5 
	else 
		local i = 0 
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then 
			i = 2 
		end 
		if i == 0 then 
			local s = math.sqrt(m00-m11-m22+1) 
			local recip = 0.5/s 
			return 0.5*s, (m10+m01)*recip, (m20+m02)*recip, (m21-m12)*recip 
		elseif i == 1 then 
			local s = math.sqrt(m11-m22-m00+1) 
			local recip = 0.5/s 
			return (m01+m10)*recip, 0.5*s, (m21+m12)*recip, (m02-m20)*recip 
		elseif i == 2 then 
			local s = math.sqrt(m22-m00-m11+1) 
			local recip = 0.5/s return (m02+m20)*recip, (m12+m21)*recip, 0.5*s, (m10-m01)*recip 
		end 
	end 
end

function QuaternionToCFrame(px, py, pz, x, y, z, w) 
	local xs, ys, zs = x + x, y + y, z + z 
	local wx, wy, wz = w*xs, w*ys, w*zs 
	local xx = x*xs 
	local xy = x*ys 
	local xz = x*zs 
	local yy = y*ys 
	local yz = y*zs 
	local zz = z*zs 
	return CFrame.new(px, py, pz,1-(yy+zz), xy - wz, xz + wy,xy + wz, 1-(xx+zz), yz - wx, xz - wy, yz + wx, 1-(xx+yy)) 
end

function QuaternionSlerp(a, b, t) 
	local cosTheta = a[1]*b[1] + a[2]*b[2] + a[3]*b[3] + a[4]*b[4] 
	local startInterp, finishInterp; 
	if cosTheta >= 0.0001 then 
		if (1 - cosTheta) > 0.0001 then 
			local theta = math.acos(cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((1-t)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta  
		else 
			startInterp = 1-t 
			finishInterp = t 
		end 
	else 
		if (1+cosTheta) > 0.0001 then 
			local theta = math.acos(-cosTheta) 
			local invSinTheta = 1/math.sin(theta) 
			startInterp = math.sin((t-1)*theta)*invSinTheta 
			finishInterp = math.sin(t*theta)*invSinTheta 
		else 
			startInterp = t-1 
			finishInterp = t 
		end 
	end 
	return a[1]*startInterp + b[1]*finishInterp, a[2]*startInterp + b[2]*finishInterp, a[3]*startInterp + b[3]*finishInterp, a[4]*startInterp + b[4]*finishInterp 
end

local function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CFrame.new(at.x, at.y, at.z,
		right.x, top.x, back.x,
		right.y, top.y, back.y,
		right.z, top.z, back.z)
end

function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
	local MoveStyle = Enum.EasingStyle[MoveStyle2]
	local outorin = Enum.EasingDirection[outorin2]
	local tweeningInformation = TweenInfo.new(AnimTime,MoveStyle,outorin,0,false,0)
	local MoveCF = CFr
	local TweenAnim = game:GetService("TweenService"):Create(SPart,tweeningInformation,MoveCF)
	TweenAnim:Play()
end

function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = Inst("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = Inst("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end


function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end

function CreateWeld(parent,part0,part1,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za)
	local weld = Instance.new("Weld")
	weld.Parent = parent
	weld.Part0 = part0
	weld.Part1 = part1
	weld.C1 = CFrame.new(C1X,C1Y,C1Z)*CFrame.Angles(C1Xa,C1Ya,C1Za)
	weld.C0 = CFrame.new(C0X,C0Y,C0Z)*CFrame.Angles(C0Xa,C0Ya,C0Za)
	return weld
end

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = Inst(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

local S = Inst("Sound")
function CreateSound(ID, PARENT, Volume, Pitch, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = Volume
		NEWSOUND.Pitch = Pitch
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false or NEWSOUND.Parent ~= PARENT
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

--WACKYEFFECT({EffectType = "", Size = Vt(1,1,1), Size2 = Vt(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = Cf(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 0})
function WACKYEFFECT(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or Vt(1,1,1))
	local ENDSIZE = (Table.Size2 or Vt(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPitch = (Table.SoundPitch or nil)
	local SOUNDVolume = (Table.SoundVolume or nil)
	local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
	local BOOMERANG = (Table.Boomerang or 0)
	local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BrickC("Pearl"), "Effect", Vt(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPitch ~= nil and SOUNDVolume ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVolume, SOUNDPitch, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = Inst("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wedge" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Wedge", "", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, Vt(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", Vt(SIZE.X,SIZE.X,0.1), Vt(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", Vt(SIZE.X/10,0,SIZE.X/10), Vt(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", Vt(SIZE.X/10,0,SIZE.X/10), Vt(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Heart" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "431221914", "", SIZE, Vt(0,0,0))
		elseif TYPE == "QMark" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "3084576726", "", SIZE, Vt(0,0,0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1+BOOMERANG/50
			local BOOMR2 = 1+SIZEBOOMERANG/50
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
				else
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
				end
			end
			local GROWTH = nil
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
			else
				GROWTH = (SIZE - ENDSIZE)
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if TYPE == "RoundBlock" then
				EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - (Vt((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vt(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame* Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if TYPE == "RoundBlock" then
						EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame* Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = Cf(EFFECT.Position,MOVEDIRECTION)*Cf(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.CFrame = Cf(EFFECT.Position)* Angles(Rad(ORI.X),Rad(ORI.Y),Rad(ORI.Z))
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vt(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame* Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if TYPE == "RoundBlock" then
						EFFECT.CFrame = CFRAME* Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame* Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = Cf(EFFECT.Position,MOVEDIRECTION)*Cf(0,0,-MOVESPEED)
						EFFECT.CFrame = Cf(EFFECT.Position)* Angles(Rad(ORI.X),Rad(ORI.Y),Rad(ORI.Z))
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

local TweenService = game:GetService("TweenService")

function Tween(obj,prop,easing,easingdir,timer)
	local easin = Enum.EasingStyle[easing]
	local easindir = Enum.EasingDirection[easingdir]
	local tweeninf = TweenInfo.new(
		timer/1,	
		easin,
		easindir,
		0,
		false,
		0
	)
	local props = prop
	local tweenanim = TweenService:Create(obj,tweeninf,props)
	tweenanim:Play()
end

--WACKYEFFECT2({Time = 60, EffectType = "Sphere", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), Color2 = C3(0,0,0),SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangeMath = false, Boomerang = 0, SizeBoomerange = 0})
function WACKYEFFECT2(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or Vt(1,1,1))
	local ENDSIZE = (Table.Size2 or Vt(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLORLOOP = (Table.ColorLoop or false)
	local COLOR = (Table.Color or C3(1,1,1))
	local COLOR2 = (Table.Color2 or C3(0,0,0))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
	local BOOMERANG = (Table.Boomerang or 0)
	local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BrickColor.new("Pearl"), "Effect", Vt(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = Inst("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wedge" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Wedge", "", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Cylinder" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Cylinder", "", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, Vt(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", Vt(SIZE.X,SIZE.X,0.1), Vt(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", Vt(SIZE.X/10,0,SIZE.X/10), Vt(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", Vt(SIZE.X/10,0,SIZE.X/10), Vt(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Heart" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "431221914", "", SIZE, Vt(0,0,0))
		elseif TYPE == "Triangle" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "627995517", "", SIZE, Vt(0,0,0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1+BOOMERANG/50
			local BOOMR2 = 1+SIZEBOOMERANG/50
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
				else
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
				end
			end
			local GROWTH = nil
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
			else
				GROWTH = (SIZE - ENDSIZE)
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			Tween(EFFECT,{Color = COLOR2},"Quad","InOut",TIME/60)
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					if COLORLOOP == true then
						EFFECT.Color = COLOR
					end
					MSH.Scale = MSH.Scale - (Vt((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vt(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = Cf(EFFECT.Position,MOVEDIRECTION)*Cf(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.Orientation = ORI
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					if COLORLOOP == true then
						EFFECT.Color = COLOR
					end
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = Vt(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*Angles(Rad(MRandom(0,360)),Rad(MRandom(0,360)),Rad(MRandom(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*Angles(Rad(ROTATION1),Rad(ROTATION2),Rad(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = Cf(EFFECT.Position,MOVEDIRECTION)*Cf(0,0,-MOVESPEED)
						EFFECT.Orientation = ORI
					end
				end
			end

			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = Inst("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = Inst("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = Inst("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function SpawnTrail2(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0.5, "Really red", "Trail", Vt(0,0,0))
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = Vt(0.5,DIST,0.5)
	else
		TRAIL.Size = Vt(0.25,DIST,0.25)
	end
	TRAIL.CFrame = Cf(FROM, TO) * Cf(0, 0, -DIST/2) * Angles(Rad(90),Rad(0),Rad(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 5 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.1
		end
		TRAIL:remove()
	end))
end


function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0.5, "White", "Trail", Vt(0,0,0))
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = Vt(0.5,DIST,0.5)
	else
		TRAIL.Size = Vt(0.25,DIST,0.25)
	end
	TRAIL.CFrame = Cf(FROM, TO) * Cf(0, 0, -DIST/2) * Angles(Rad(90),Rad(0),Rad(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 5 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.1
		end
		TRAIL:remove()
	end))
end

function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BrickC(COLOR), "Effect", Vt(1,1,1), true)
	local mesh = Inst("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = Vt(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function MagicSphereCo(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BrickC(COLOR), "Effect", Vt(1,1,1), true)
	local mesh = Inst("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = Vt(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function MagicBlock(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "ForceField", 0, 0.5, BrickC(COLOR), "Effect", Vt(SIZE,SIZE,SIZE), true)
	local mesh = Inst("BlockMesh",wave)
	wave.CFrame = CFRAME * Angles(Rad(math.random(-360,360)),Rad(math.random(-360,360)),Rad(math.random(-360,360)))
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.CFrame = CFRAME * Angles(Rad(math.random(-360,360)),Rad(math.random(-360,360)),Rad(math.random(-360,360)))
			wave.Transparency = wave.Transparency + (0.5/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function CreateRing(SIZE, DOESROT, ROT, WAIT, CFRAME, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BrickC(COLOR), "Effect", Vt(0, 0, 0))
	local mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "559831844", "", SIZE, Vt(0, 0, 0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0, ROT, 0)
			end
			wave.Transparency = wave.Transparency + 0.5 / WAIT
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

local DECAL = Inst("Decal")
function MagicRing()
	local RING = CreatePart(3, Effects, "Granite", 0, 1, "Maroon", "MagicRing", Vt(0,0,0),true)
	local MESH = Inst("BlockMesh",RING)
	local BOTTOMTEXTURE = DECAL:Clone()
	BOTTOMTEXTURE.Parent = RING
	BOTTOMTEXTURE.Face = "Bottom"
	BOTTOMTEXTURE.Name = "BottomTexture"
	local TOPTEXTURE = DECAL:Clone()
	TOPTEXTURE.Parent = RING
	TOPTEXTURE.Face = "Top"
	TOPTEXTURE.Name = "TopTexture"
	BOTTOMTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	TOPTEXTURE.Texture = "http://www.roblox.com/asset/?id=1208118228"
	BOTTOMTEXTURE.Color3 = C3(0,0,0)
	TOPTEXTURE.Color3 = C3(1,1,1)
	return RING,MESH,TOPTEXTURE,BOTTOMTEXTURE
end

Debris = game:GetService("Debris")

function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = Cf(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,Vt(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end

Create = function(Obj)
	local Ins = Instance.new(Obj)
	return function(Property)
		if Property then
			for Property_,Value_ in next, Property do
				Ins[Property_] = Value_
			end
			return Ins
		else
			return Ins
		end
	end
end

CFuncs = {["Part"] = {
	Create = function(Parent, Material, Reflectance, Transparency, BColor, Name, Size)
		local Part = Create("Part"){
			Parent = Parent,
			Reflectance = Reflectance,
			Transparency = Transparency,
			CanCollide = false,
			Locked = true,
			BrickColor = BrickColor.new(tostring(BColor)),
			Name = Name,
			Size = Size,
			Material = Material,
		}
		--RemoveOutlines(Part)
		return Part
	end;
};

["Mesh"] = {
	Create = function(Mesh, Part, MeshType, MeshId, OffSet, Scale)
		local Msh = Create(Mesh){
			Parent = Part,
			Offset = OffSet,
			Scale = Scale,
		}
		if Mesh == "SpecialMesh" then
			Msh.MeshType = MeshType
			Msh.MeshId = MeshId
		end
		return Msh
	end;
};

["Weld"] = {
	Create = function(Parent, Part0, Part1, C0, C1)
		local Weld = Create("Weld"){
			Parent = Parent,
			Part0 = Part0,
			Part1 = Part1,
			C0 = C0,
			C1 = C1,
		}
		return Weld
	end;
};

["Sound"] = {
	Create = function(id, par, vol, pit) 
		coroutine.resume(coroutine.create(function()
			local S = Create("Sound"){
				Volume = vol,
				Name = "EffectSoundo",
				Pitch = pit or 1,
				SoundId = id,
				Parent = par or workspace,
			}
			wait() 
			S:play() 
			game:GetService("Debris"):AddItem(S, 10)
		end))
	end;
};

["TimeSound"] = {
	Create = function(id, par, vol, pit, timepos) 
		coroutine.resume(coroutine.create(function()
			local S = Create("Sound"){
				Volume = vol,
				Name = "EffectSoundo",
				Pitch = pit or 1,
				SoundId = id,
				TimePosition = timepos,
				Parent = par or workspace,
			}
			wait() 
			S:play() 
			game:GetService("Debris"):AddItem(S, 10)
		end))
	end;
};
["EchoSound"] = {
	Create = function(id, par, vol, pit, timepos,delays,echodelay,fedb,dryl) 
		coroutine.resume(coroutine.create(function()
			local Sas = Create("Sound"){
				Volume = vol,
				Name = "EffectSoundo",
				Pitch = pit or 1,
				SoundId = id,
				TimePosition = timepos,
				Parent = par or workspace,
			}
			local E = Create("EchoSoundEffect"){
				Delay = echodelay,
				Name = "Echo",
				Feedback = fedb,
				DryLevel = dryl,
				Parent = Sas,
			}
			wait() 
			Sas:play() 
			game:GetService("Debris"):AddItem(Sas, delays)
		end))
	end;
};

["LongSound"] = {
	Create = function(id, par, vol, pit) 
		coroutine.resume(coroutine.create(function()
			local S = Create("Sound"){
				Volume = vol,
				Pitch = pit or 1,
				SoundId = id,
				Parent = par or workspace,
			}
			wait() 
			S:play() 
			game:GetService("Debris"):AddItem(S, 60)
		end))
	end;
};

["ParticleEmitter"] = {
	Create = function(Parent, Color1, Color2, LightEmission, Size, Texture, Transparency, ZOffset, Accel, Drag, LockedToPart, VelocityInheritance, EmissionDirection, Enabled, LifeTime, Rate, Rotation, RotSpeed, Speed, VelocitySpread)
		local fp = Create("ParticleEmitter"){
			Parent = Parent,
			Color = ColorSequence.new(Color1, Color2),
			LightEmission = LightEmission,
			Size = Size,
			Texture = Texture,
			Transparency = Transparency,
			ZOffset = ZOffset,
			Acceleration = Accel,
			Drag = Drag,
			LockedToPart = LockedToPart,
			VelocityInheritance = VelocityInheritance,
			EmissionDirection = EmissionDirection,
			Enabled = Enabled,
			Lifetime = LifeTime,
			Rate = Rate,
			Rotation = Rotation,
			RotSpeed = RotSpeed,
			Speed = Speed,
			VelocitySpread = VelocitySpread,
		}
		return fp
	end;
};

CreateTemplate = {

};
}

function ApplyDamage(Humanoid, Damage)
	Damage = Damage * DamageMultiplier
	if Humanoid.Health < 2000 then
		if Humanoid.Health - Damage > 0 then
			Humanoid.Health = Humanoid.Health - Damage
		else
			Humanoid.Parent:BreakJoints()
		end
	else
		Humanoid.Parent:BreakJoints()
	end
end
function ApplyAoE(POSITION, RANGE, MINDMG, MAXDMG, FLING, INSTAKILL)
	for index, CHILD in pairs(workspace:GetDescendants()) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO and RANGE >= (TORSO.Position - POSITION).Magnitude then
					if INSTAKILL == true then
						CHILD:BreakJoints()
					else
						local DMG = MRandom(MINDMG, MAXDMG)
						ApplyDamage(HUM, DMG)
					end
					if FLING > 0 then
						for _, c in pairs(CHILD:GetChildren()) do
							if c:IsA("BasePart") then
								local bv = Instance.new("BodyVelocity")
								bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
								bv.velocity = Cf(POSITION, TORSO.Position).lookVector * FLING
								bv.Parent = c
								Debris:AddItem(bv, 0.05)
							end
						end
					end
				end
			end
		end
	end
end

function Slash(bonuspeed,rotspeed,rotatingop,typeofshape,type,typeoftrans,pos,scale,value,color)
	local type = type
	local rotenable = rotatingop
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.Color = color
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	if typeofshape == "Normal" then
		rngm.MeshId = "rbxassetid://662586858"
	elseif typeofshape == "Round" then
		rngm.MeshId = "rbxassetid://662585058"
	end
	rngm.Scale = scale
	local scaler2 = 1/10
	if type == "Add" then
		scaler2 = 1*value/10
	elseif type == "Divide" then
		scaler2 = 1/value/10
	end
	local randomrot = math.random(1,2)
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed/10
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed/10
			end
			if rotenable == true then
				if randomrot == 1 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(rotspeed*bonuspeed/2),0)
				elseif randomrot == 2 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-rotspeed*bonuspeed/2),0)
				end
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed/10, 0, scaler2*bonuspeed/10)
		end
		rng:Destroy()
	end))
end

function CreateFlyingDebree(Floor, Position, Amount, BlockSize, SWait, Strenght, DOES360)
	if Floor ~= nil then
		for i = 1, Amount do
			do
				local Debree = nil
				if BlockSize == "randomsmol" then
					local rand = math.random(2,5)
					local vtr = Vt(rand,rand,rand)
					Debree = CreatePart(3, Effects, "Neon", 0, 0, "Peal", "Debree", vtr, false)
				else
					Debree = CreatePart(3, Effects, "Neon", 0, 0, "Peal", "Debree", BlockSize, false)
				end
				Debree.Material = Floor.Material
				Debree.Color = Floor.Color
				Debree.CFrame = Position * Angles(Rad(MRandom(-360, 360)), Rad(MRandom(-360, 360)), Rad(MRandom(-360, 360)))
				if DOES360 == true then
					Debree.Velocity = Vt(MRandom(-Strenght, Strenght), MRandom(-Strenght, Strenght), MRandom(-Strenght, Strenght))
				else
					Debree.Velocity = Vt(MRandom(-Strenght, Strenght), Strenght, MRandom(-Strenght, Strenght))
				end
				coroutine.resume(coroutine.create(function()
					Swait(15)
					Debree.Parent = workspace
					Debree.CanCollide = true
					Debris:AddItem(Debree, SWait)
				end))
			end
		end
	end
end

function ShakeCamera(Position, Range, Inensity, Time)
	local Children = workspace:GetDescendants()
	for index, Child in pairs(Children) do
		if Child.ClassName == "Model" then
			local HUM = Child:FindFirstChildOfClass("Humanoid")
			if HUM then
				local Torso = Child:FindFirstChild("HumanoidRootPart")
				if Torso and Range >= (Torso.Position - Position).Magnitude then
					local CAMSHAKER = script.CameraShake:Clone()
					CAMSHAKER.Shake.Value = Inensity
					CAMSHAKER.Timer.Value = Time
					CAMSHAKER.Parent = Child
					CAMSHAKER.Disabled = false
				end
			end
		end
	end
end

------------------------------------
pcall(function()
Humanoid.Animator.Parent = nil
end)
------------------------------------

function createBGCircle(size,parent,color)
	local bgui = Instance.new("BillboardGui",parent)
	bgui.Size = UDim2.new(size, 0, size, 0)
	local imgc = Instance.new("ImageLabel",bgui)
	imgc.BackgroundTransparency = 1
	imgc.ImageTransparency = 0
	imgc.Size = UDim2.new(1,0,1,0)
	imgc.Image = "rbxassetid://997291547" --997291547,521073910
	imgc.ImageColor3 = color
	return bgui,imgc
end

function symbolizeBlink(guipar,size,img,color,bonussize,vol,pit,soundid,spar,rotationenabled,rotsp,delay)
	local bgui,imgc = createBGCircle(size,guipar,color)
	bgui.AlwaysOnTop = true
	imgc.Image = "rbxassetid://" ..img
	local rrot = math.random(1,2)
	CFuncs["Sound"].Create("rbxassetid://" ..soundid, spar, vol,pit)
	coroutine.resume(coroutine.create(function()
		for i = 0, 24*delay do
			swait()
			if rotationenabled == true then
				if rrot == 1 then
					imgc.Rotation = imgc.Rotation + rotsp
				elseif rrot == 2 then
					imgc.Rotation = imgc.Rotation - rotsp
				end
			end
			bgui.Size = bgui.Size + UDim2.new(1*bonussize/delay,0,1*bonussize/delay,0)
			imgc.ImageTransparency = imgc.ImageTransparency + 0.04/delay
		end
		bgui:Destroy()
	end))
end

--local Nametag = script.Nametag:Clone()
--Nametag.Parent = Character
--.Adornee = Torso
--local ModeName = Nametag.Mode

function ChangeMode(Name,Modes,Color1,Color2)
	local Effecto = {3283625874,3283625303,3283626691,3283626241}
	CFuncs["EchoSound"].Create("rbxassetid://9062843158", Torso, 1, 1,0,10,0.25,0.25,1)
	CFuncs["EchoSound"].Create("rbxassetid://"..Effecto[math.random(1,#Effecto)], Torso, 1, 1,0,10,0.25,0.25,1)
	symbolizeBlink(Torso,0,2092248396,Color1,5,3,1,847061203,Torso,true,10,1)
	symbolizeBlink(Torso,0,2092248396,Color1,4,0,0,0,Torso,true,-5,1)
	--ModeName.Text = Name
	--ModeName.TextColor3 = Color1
	--ModeName.TextStrokeColor3 = Color2
	if Modes == 1 then
		Mode = 1
		Visual = 9936321839
	elseif Modes == 2 then
		Mode = 2
		Visual = 9936434955
	elseif Modes == 3 then
		Mode = 3
		Visual = 9936465119
	end
end

--//-------------------------------------\\--
--|       End Functions and Stuff         |--
--\\-------------------------------------//--

--//-------------------------------------\\--
--|               Welding                 |--
--\\-------------------------------------//--



--//-------------------------------------\\--
--|               Attacks                 |--
--\\-------------------------------------//--

function TemplateAttack()
	Attack = true
	Rooted = false
	for i = 0,15 do
		Swait()
		NewAnim({
			RootJoint = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RootJointDelay = NewAnimSpeed,
			Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
			Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
			RightShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightShoulderDelay = NewAnimSpeed,
			RightElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
			RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
			LeftShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftShoulderDelay = NewAnimSpeed,
			LeftElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
			LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
			RightHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightHipDelay = NewAnimSpeed,
			RightAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightAnkleDelay = NewAnimSpeed,
			RightKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightKneeDelay = NewAnimSpeed,
			LeftHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftHipDelay = NewAnimSpeed,
			LeftAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftAnkleDelay = NewAnimSpeed,
			LeftKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftKneeDelay = NewAnimSpeed,
		},"Lerp")
	end
	Rooted = false
	Attack = false
end

--//-------------------------------------\\--
--|       Buttton/Keys for attacks        |--
--\\-------------------------------------//--

function MouseDown(Mouse)
	if Attack == false then
		
	end
end

function MouseUp(Mouse)
	Hold = false
end
ChangeMode("Purity",2,Color3.new(0, 1, 0.835294),Color3.new(1, 1, 1))
function KeyDown(Button)
	KeyHold = true
	if Button == "1" and Attack == false then
		ChangeMode("Mayhem",1,Color3.new(1, 0, 0),Color3.new(0.670588, 0, 0))
	end
	if Button == "2" and Attack == false then
		ChangeMode("Purity",2,Color3.new(0, 1, 0.835294),Color3.new(1, 1, 1))
	end
	if Button == "3" and Attack == false then
		ChangeMode("Death",3,Color3.new(0, 0, 0),Color3.new(1, 1, 1))
	end
	if Button == "x" and Attack == false then

	end
	if Button == "c" and Attack == false then
		
	end
	if Button == "m" then
		Volume = 0
	elseif Button == "n" then
		Volume = 3
	end
end

function KeyUp(Key)
	KeyHold = false
end

Mouse.Button1Down:Connect(function(Button)MouseDown(Button)end)
Mouse.Button1Up:Connect(function(Button)MouseUp(Button)end)
Mouse.KeyDown:Connect(function(Button)KeyDown(Button)end)
Mouse.KeyUp:Connect(function(Button)KeyUp(Button)end)

--//-------------------------------------\\--
--|       End Buttton/Keys for attacks    |--
--\\-------------------------------------//--
--[[
NewAnim({
	RootJoint = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RootJointDelay = NewAnimSpeed,
	Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
	Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
	RightShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightShoulderDelay = NewAnimSpeed,
	RightElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
	RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
	LeftShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftShoulderDelay = NewAnimSpeed,
	LeftElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
	LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
	RightHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightHipDelay = NewAnimSpeed,
	RightAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightAnkleDelay = NewAnimSpeed,
	RightKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightKneeDelay = NewAnimSpeed,
	LeftHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftHipDelay = NewAnimSpeed,
	LeftAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftAnkleDelay = NewAnimSpeed,
	LeftKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftKneeDelay = NewAnimSpeed,
},"Lerp")
]]
for x,c in pairs(Head:GetDescendants())do if c:IsA("Sound") then c:Destroy();end;end; -- Removes sounds from the head
while true do
	Swait()
	pcall(function()Character:FindFirstChild("Animate").Parent=nil;end)
	if Character:FindFirstChildOfClass("Humanoid")==nil then Humanoid=Inst("Humanoid",Character);end;
	for _,v in next,Humanoid:GetPlayingAnimationTracks() do v:Stop();end;
	Sine=Sine+Change*2
	local HitFloor,HitPosition = Raycast(RootPart.Position,(Cf(RootPart.Position, RootPart.Position + Vt(0, -1, 0))).lookVector, 4, Character)
	local TiltVelocity = Cf(RootPart.CFrame:vectorToObjectSpace(RootPart.Velocity/1.6))
	local TorsoVelocity = (RootPart.Velocity * Vt(1, 0, 1)).magnitude
	local TorsoVerticalVelocity = RootPart.Velocity.y
	local WalkSpeedValue = 12 / (Humanoid.WalkSpeed / 23)
	local SideVec = Clamp((RootPart.Velocity*RootPart.CFrame.RightVector).X+(RootPart.Velocity*RootPart.CFrame.RightVector).Z,-Humanoid.WalkSpeed,Humanoid.WalkSpeed)
	local ForwardVec =  Clamp((RootPart.Velocity*RootPart.CFrame.LookVector).X+(RootPart.Velocity*RootPart.CFrame.LookVector).Z,-Humanoid.WalkSpeed,Humanoid.WalkSpeed)
	local SideVelocity = SideVec/Humanoid.WalkSpeed
	local ForwardVelocity = ForwardVec/Humanoid.WalkSpeed
	if Humanoid.Sit == true then
		Anim = "Sit"
		if Attack == false then
			NewAnimSpeed = 0.1
			NewAnim({
				RootJoint = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RootJointDelay = NewAnimSpeed,
				Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
				Neck = Cf(0, 0, 0) * Angles(Rad(0), Rad(0), Rad(0)),NeckDelay = NewAnimSpeed,
				RightShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightShoulderDelay = NewAnimSpeed,
				RightElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
				RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
				LeftShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftShoulderDelay = NewAnimSpeed,
				LeftElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
				LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
				RightHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightHipDelay = NewAnimSpeed,
				RightKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightKneeDelay = NewAnimSpeed,
				RightAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightAnkleDelay = NewAnimSpeed,
				LeftHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftHipDelay = NewAnimSpeed,
				LeftKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftKneeDelay = NewAnimSpeed,
				LeftAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftAnkleDelay = NewAnimSpeed,
			},"Lerp")
		end
	elseif TorsoVerticalVelocity > 1 and HitFloor == nil then
		Anim = "Jump"
		if Attack == false then
			NewAnimSpeed = 0.1
			NewAnim({
				RootJoint = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RootJointDelay = NewAnimSpeed,
				Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
				Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
				RightShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightShoulderDelay = NewAnimSpeed,
				RightElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
				RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
				LeftShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftShoulderDelay = NewAnimSpeed,
				LeftElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
				LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
				RightHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightHipDelay = NewAnimSpeed,
				RightAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightAnkleDelay = NewAnimSpeed,
				RightKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightKneeDelay = NewAnimSpeed,
				LeftHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftHipDelay = NewAnimSpeed,
				LeftAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftAnkleDelay = NewAnimSpeed,
				LeftKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftKneeDelay = NewAnimSpeed,
			},"Lerp")
		end
	elseif TorsoVerticalVelocity < -1 and HitFloor == nil then
		Anim = "Fall"
		if Attack == false then
			NewAnimSpeed = 0.1
			NewAnim({
				RootJoint = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RootJointDelay = NewAnimSpeed,
				Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
				Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
				RightShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightShoulderDelay = NewAnimSpeed,
				RightElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
				RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
				LeftShoulder = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftShoulderDelay = NewAnimSpeed,
				LeftElbow = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
				LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
				RightHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightHipDelay = NewAnimSpeed,
				RightAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightAnkleDelay = NewAnimSpeed,
				RightKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightKneeDelay = NewAnimSpeed,
				LeftHip = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftHipDelay = NewAnimSpeed,
				LeftAnkle = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftAnkleDelay = NewAnimSpeed,
				LeftKnee = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftKneeDelay = NewAnimSpeed,
			},"Lerp")
		end
	elseif TorsoVelocity < 1 and HitFloor ~= nil then
		Anim = "Idle"
		if Attack == false then
			NewAnimSpeed = 1
			if Mode == 1 then
				NewAnim({
					RootJoint = Cf(-0.311, -0.068+0.1*Sin(Sine/65), -0.162-0.15*Sin(Sine/65)) * Angles(Rad(-13.293), Rad(-3.839), Rad(-2.865)),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(-3.266), 0, 0),WaistDelay = NewAnimSpeed,
					Neck = Cf(0, 0, 0) * Angles(Rad(0), Rad(0), Rad(0)),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0.002, -0.007, 0.2) * Angles(Rad(81.303), Rad(26.7), Rad(-38.044)),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(92.132), Rad(1.203), Rad(-9.855)),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(-8.537), Rad(-43.831), Rad(-21.658)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(22.689+math.random(-2,2)), Rad(-18.105), Rad(-4.24+math.random(-2,2))),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(-0.057), 0, 0),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(0,0,0) * Angles(Rad(23.549-15*Sin(Sine/65)), Rad(4.412), Rad(8.251)),RightHipDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0) * Angles(Rad(-26.07+15*Sin(Sine/65)), 0, 0),RightKneeDelay = NewAnimSpeed,
					RightAnkle = Cf(0,0,0) * Angles(Rad(15.814-3*Sin(Sine/65)), Rad(1.146), Rad(-7.047)),RightAnkleDelay = NewAnimSpeed,
					LeftHip = Cf(0,0,0) * Angles(Rad(31.742-15*Sin(Sine/65)), Rad(-1.891), Rad(-8.193)),LeftHipDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0) * Angles(Rad(-16.616+10*Sin(Sine/65)), 0, 0),LeftKneeDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0) * Angles(Rad(-5.615+3*Sin(Sine/65)), Rad(18.392), Rad(7.792)),LeftAnkleDelay = NewAnimSpeed,
				},"Lerp")
			elseif Mode == 2 then
				NewAnim({
					RootJoint = Cf(-0.311, -0.068+0.1*Sin(Sine/65), -0.162-0.15*Sin(Sine/65)) * Angles(Rad(-13.293), Rad(-3.839), Rad(-2.865)),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(-3.266), 0, 0),WaistDelay = NewAnimSpeed,
					Neck = Cf(0, 0, 0) * Angles(Rad(0), Rad(0), Rad(0)),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0.002, -0.007, 0.2) * Angles(Rad(-22.689-math.random(-2,2)), Rad(18.105), Rad(4.24+math.random(-2,2))),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(-0.057), 0, 0),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(22.689+math.random(-2,2)), Rad(-18.105), Rad(-4.24+math.random(-2,2))),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(-0.057), 0, 0),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(0,0,0) * Angles(Rad(23.549-15*Sin(Sine/65)), Rad(4.412), Rad(8.251)),RightHipDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0) * Angles(Rad(-26.07+15*Sin(Sine/65)), 0, 0),RightKneeDelay = NewAnimSpeed,
					RightAnkle = Cf(0,0,0) * Angles(Rad(15.814-3*Sin(Sine/65)), Rad(1.146), Rad(-7.047)),RightAnkleDelay = NewAnimSpeed,
					LeftHip = Cf(0,0,0) * Angles(Rad(31.742-15*Sin(Sine/65)), Rad(-1.891), Rad(-8.193)),LeftHipDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0) * Angles(Rad(-16.616+10*Sin(Sine/65)), 0, 0),LeftKneeDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0) * Angles(Rad(-5.615+3*Sin(Sine/65)), Rad(18.392), Rad(7.792)),LeftAnkleDelay = NewAnimSpeed,
				},"Lerp")
			elseif Mode == 3 then
				NewAnim({
					RootJoint = Cf(0+2*Sin(Sine/78), 1.334-0.8 * Sin(Sine/45), 0+1*Sin(Sine/63)) * Angles(Rad(4.354), 0, 0),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(-8.824), 0, 0),WaistDelay = NewAnimSpeed,
					Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0,0,0) * Angles(Rad(79.87+23*Sin(Sine/47)), Rad(-41.654+23*Sin(Sine/47)), Rad(63.885)),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(58.041-12*Sin(Sine/47)), 0, 0),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(3.38), Rad(-0.229), Rad(-6.188)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(77.177+23*Sin(Sine/47)), Rad(43.373-23*Sin(Sine/47)), Rad(-35.065)),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(62.911-32*Sin(Sine/47)), 0, 0),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(8.652), Rad(0.401), Rad(16.043)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(0,0,0) * Angles(Rad(-10.657-15*Sin(Sine/45)), Rad(0.573), Rad(-0.344)),RightHipDelay = NewAnimSpeed,
					RightAnkle = Cf(0,0,0) * Angles(Rad(-16.558-19*Sin(Sine/45)), 0, 0),RightAnkleDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0) * Angles(Rad(-27.788), Rad(0.057), Rad(-0.401)),RightKneeDelay = NewAnimSpeed,
					LeftHip = Cf(0,0,0) * Angles(Rad(5.672+5*Sin(Sine/45)), Rad(-1.089), Rad(0.917)),LeftHipDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0) * Angles(Rad(-22.517+8*Sin(Sine/45)), 0, 0),LeftAnkleDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0) * Angles(Rad(-33.69), 0, Rad(0.859)),LeftKneeDelay = NewAnimSpeed,
				},"Lerp")
			end
		end
	elseif TorsoVelocity > 1 and HitFloor ~= nil then
		Anim = "Walk"
		if Attack == false then
			NewAnimSpeed = 1
			if Mode == 2 then
				local Ccf=Cf(RootPart.CFrame.p*Vt(1,0,1),(RootPart.CFrame.p+RootPart.CFrame.LookVector)*Vt(1,0,1))
				local Walktest1 = Humanoid.MoveDirection*Ccf.LookVector
				local Walktest2 = Humanoid.MoveDirection*Ccf.RightVector
				forWFB = Walktest1.X+Walktest1.Z
				forWRL = Walktest2.X+Walktest2.Z
				WalkSpeedValue = 12 / (Humanoid.WalkSpeed / 45)
				NewAnim({
					RootJoint = Cf(.1*forWRL*Cos(Sine/WalkSpeedValue),.1*Sin(Sine/WalkSpeedValue),.1*forWFB*Cos(Sine/WalkSpeedValue))*Angles(Rad((-forWFB*10)-(forWFB*7.5)*Sin(Sine/WalkSpeedValue)),Rad((-20*Cos(Sine/WalkSpeedValue))+(-forWRL*5)),Rad(((-forWRL*5)+(forWRL*5)*Sin(Sine/WalkSpeedValue))-5*forWFB*Cos(Sine/WalkSpeedValue))),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
					Neck = Cf(0,0,0)*Angles(Rad((forWFB*10)+(forWFB*(10/2))*Sin(Sine/WalkSpeedValue)),Rad(((10)*Cos(Sine/WalkSpeedValue))+(-45*forWRL)),Rad((forWRL*(10/2))+(forWRL*(10/2))*Sin(Sine/WalkSpeedValue))),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0,0,0) * Angles(Rad(0+63*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.Z)*2.3),Rad(13*Cos(Sine/WalkSpeedValue))-Rad(TiltVelocity.Y)*3.7,Rad(5+13*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.X)*2.1)),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(21+25*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(0-63*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.Z)*2.3),Rad(13*Cos(Sine/WalkSpeedValue))+Rad(TiltVelocity.Y)*3.7,Rad(-5-13*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.X)*2.1)),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(21-25*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(-0.1*forWRL*Sin(Sine/WalkSpeedValue),0,0.1*forWFB*Sin(Sine/WalkSpeedValue))*Angles(Rad(((-forWRL*10)*Sin(Sine/WalkSpeedValue) )+( (1*20)-(1*20)*Cos(Sine/WalkSpeedValue) )+(-forWFB*25)*Sin(Sine/WalkSpeedValue) ),Rad(10*Cos(Sine/WalkSpeedValue)),Rad(((-forWRL*25)*Sin(Sine/WalkSpeedValue) )+forWRL*0)),RightHipDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0)*Angles(Rad(-40+(1*40)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(forWRL*0)),RightKneeDelay = NewAnimSpeed,
					RightAnkle =Cf(0,0,0)*Angles(Rad((forWFB*10)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(-(forWRL*10)*Cos(Sine/WalkSpeedValue)  )),RightAnkleDelay = NewAnimSpeed,
					LeftHip = Cf(0.1*forWRL*Sin(Sine/WalkSpeedValue),0,-0.1*forWFB*Sin(Sine/WalkSpeedValue))*Angles(Rad(((forWRL*10)*Sin(Sine/WalkSpeedValue))+((1*20)+(1*20)*Cos(Sine/WalkSpeedValue) )-(-forWFB*25)*Sin(Sine/WalkSpeedValue) ),Rad(10*Cos(Sine/WalkSpeedValue)),Rad((-(-forWRL*25)*Sin(Sine/WalkSpeedValue) )+forWRL*0)),LeftHipDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0)*Angles(Rad( -40-(1*40)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(forWRL*0)),LeftKneeDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0)*Angles(Rad(-(forWFB*10)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad((forWRL*10)*Cos(Sine/WalkSpeedValue)  )),LeftAnkleDelay = NewAnimSpeed,
				},"Lerp")
			elseif Mode == 3 then
				NewAnim({
					RootJoint = Cf(0+2*Sin(Sine/78), 1.334-0.8 * Sin(Sine/45), 0+1*Sin(Sine/63)) * Angles(Rad(4.354), 0, 0),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(-8.824), 0, 0),WaistDelay = NewAnimSpeed,
					Neck = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0,0,0) * Angles(Rad(79.87+23*Sin(Sine/47)), Rad(-41.654+23*Sin(Sine/47)), Rad(63.885)),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(58.041-12*Sin(Sine/47)), 0, 0),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(3.38), Rad(-0.229), Rad(-6.188)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(77.177+23*Sin(Sine/47)), Rad(43.373-23*Sin(Sine/47)), Rad(-35.065)),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(62.911-32*Sin(Sine/47)), 0, 0),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(8.652), Rad(0.401), Rad(16.043)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(0,0,0) * Angles(Rad(-10.657-15*Sin(Sine/45)), Rad(0.573), Rad(-0.344)),RightHipDelay = NewAnimSpeed,
					RightAnkle = Cf(0,0,0) * Angles(Rad(-16.558-19*Sin(Sine/45)), 0, 0),RightAnkleDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0) * Angles(Rad(-27.788), Rad(0.057), Rad(-0.401)),RightKneeDelay = NewAnimSpeed,
					LeftHip = Cf(0,0,0) * Angles(Rad(5.672+5*Sin(Sine/45)), Rad(-1.089), Rad(0.917)),LeftHipDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0) * Angles(Rad(-22.517+8*Sin(Sine/45)), 0, 0),LeftAnkleDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0) * Angles(Rad(-33.69), 0, Rad(0.859)),LeftKneeDelay = NewAnimSpeed,
				},"Lerp")
			else
				local Ccf=Cf(RootPart.CFrame.p*Vt(1,0,1),(RootPart.CFrame.p+RootPart.CFrame.LookVector)*Vt(1,0,1))
				local Walktest1 = Humanoid.MoveDirection*Ccf.LookVector
				local Walktest2 = Humanoid.MoveDirection*Ccf.RightVector
				forWFB = Walktest1.X+Walktest1.Z
				forWRL = Walktest2.X+Walktest2.Z
				WalkSpeedValue = 12 / (Humanoid.WalkSpeed / 45)
				NewAnim({
					RootJoint = Cf(.1*forWRL*Cos(Sine/WalkSpeedValue),.1*Sin(Sine/WalkSpeedValue),.1*forWFB*Cos(Sine/WalkSpeedValue))*Angles(Rad((-forWFB*10)-(forWFB*7.5)*Sin(Sine/WalkSpeedValue)),Rad((-20*Cos(Sine/WalkSpeedValue))+(-forWRL*5)),Rad(((-forWRL*5)+(forWRL*5)*Sin(Sine/WalkSpeedValue))-5*forWFB*Cos(Sine/WalkSpeedValue))),RootJointDelay = NewAnimSpeed,
					Waist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),WaistDelay = NewAnimSpeed,
					Neck = Cf(0,0,0)*Angles(Rad((forWFB*10)+(forWFB*(10/2))*Sin(Sine/WalkSpeedValue)),Rad(((10)*Cos(Sine/WalkSpeedValue))+(-45*forWRL)),Rad((forWRL*(10/2))+(forWRL*(10/2))*Sin(Sine/WalkSpeedValue))),NeckDelay = NewAnimSpeed,
					RightShoulder = Cf(0,0,0) * Angles(Rad(0+63*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.Z)*2.3),Rad(13*Cos(Sine/WalkSpeedValue))-Rad(TiltVelocity.Y)*3.7,Rad(5+13*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.X)*2.1)),RightShoulderDelay = NewAnimSpeed,
					RightElbow = Cf(0,0,0) * Angles(Rad(21+25*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(0)),RightElbowDelay = NewAnimSpeed,
					RightWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),RightWristDelay = NewAnimSpeed,
					LeftShoulder = Cf(0,0,0) * Angles(Rad(0-63*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.Z)*2.3),Rad(13*Cos(Sine/WalkSpeedValue))+Rad(TiltVelocity.Y)*3.7,Rad(-5-13*Cos(Sine/WalkSpeedValue)*-Rad(TiltVelocity.X)*2.1)),LeftShoulderDelay = NewAnimSpeed,
					LeftElbow = Cf(0,0,0) * Angles(Rad(21-25*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(0)),LeftElbowDelay = NewAnimSpeed,
					LeftWrist = Cf(0,0,0) * Angles(Rad(0),Rad(0),Rad(0)),LeftWristDelay = NewAnimSpeed,
					RightHip = Cf(-0.1*forWRL*Sin(Sine/WalkSpeedValue),0,0.1*forWFB*Sin(Sine/WalkSpeedValue))*Angles(Rad(((-forWRL*10)*Sin(Sine/WalkSpeedValue) )+( (1*20)-(1*20)*Cos(Sine/WalkSpeedValue) )+(-forWFB*25)*Sin(Sine/WalkSpeedValue) ),Rad(10*Cos(Sine/WalkSpeedValue)),Rad(((-forWRL*25)*Sin(Sine/WalkSpeedValue) )+forWRL*0)),RightHipDelay = NewAnimSpeed,
					RightKnee = Cf(0,0,0)*Angles(Rad(-40+(1*40)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(forWRL*0)),RightKneeDelay = NewAnimSpeed,
					RightAnkle =Cf(0,0,0)*Angles(Rad((forWFB*10)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(-(forWRL*10)*Cos(Sine/WalkSpeedValue)  )),RightAnkleDelay = NewAnimSpeed,
					LeftHip = Cf(0.1*forWRL*Sin(Sine/WalkSpeedValue),0,-0.1*forWFB*Sin(Sine/WalkSpeedValue))*Angles(Rad(((forWRL*10)*Sin(Sine/WalkSpeedValue))+((1*20)+(1*20)*Cos(Sine/WalkSpeedValue) )-(-forWFB*25)*Sin(Sine/WalkSpeedValue) ),Rad(10*Cos(Sine/WalkSpeedValue)),Rad((-(-forWRL*25)*Sin(Sine/WalkSpeedValue) )+forWRL*0)),LeftHipDelay = NewAnimSpeed,
					LeftKnee = Cf(0,0,0)*Angles(Rad( -40-(1*40)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad(forWRL*0)),LeftKneeDelay = NewAnimSpeed,
					LeftAnkle = Cf(0,0,0)*Angles(Rad(-(forWFB*10)*Cos(Sine/WalkSpeedValue)),Rad(0),Rad((forWRL*10)*Cos(Sine/WalkSpeedValue)  )),LeftAnkleDelay = NewAnimSpeed,
				},"Lerp")
			end
		end
	end
	if MSound.Parent ~= Torso then
		MSound = Inst("Sound", Torso)
	end
	MSound.Parent = Torso
	MSound.Playing = true
	MSound.Looped = true
	MSound.Volume = Volume
	MSound.Pitch = Pitch
	MSound.SoundId = "rbxassetid://"..Visual
	MSound.Name = "Music"
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = 16
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	Humanoid.MaxHealth = 'inf'
	Humanoid.Health = 'inf'
end
