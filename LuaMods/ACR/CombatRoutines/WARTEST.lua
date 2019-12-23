local profile = {}

--[[
Current Fixes:
	-Now takes into account the hitradius of an entity to determine the max range you can attack.
	-Proper support for DoT'ing multiple enemies around you, with the ability to set a max DoT'ed entity count.
	-Rotate songs
	-For single target battles, Raging Strikes lines up with Minuet.
	-The ability to choose whether or not your AoE is allowed to hit enemies that aren't currently in battle.
	-Automatically select the best target for AoE, for both Rain of Death and Quick Nock.
	-Use DoTs on any enemy, even if they aren't in front of you, as well as Iron Jaws.
	-Use Misery's End on any enemy, will switch target to use skill, then switch back. Probably needs further tweaking.

]]

profile.classes = {
    [FFXIV.JOBS.BARD] = true,
}

profile.GUI = {
    open = false,
    visible = true,
    debug = false,
    name = "Kali's Bard",
}

profile.DebugGUI = {
    open = false,
    visible = true,
    name = "Bard Debug",
}

profile.PriorityGUI = {
    open = false,
    visible = true,
    name = "Bard Skill Priorities",
}

function profile.WindowStyle()
	-- GUI:PushStyleColor(GUI.Col_Text, , , , )
	-- GUI:PushStyleColor(GUI.Col_TextDisabled, , , , )
	GUI:PushStyleColor(GUI.Col_WindowBg, 0.0274509803921569, 0, 0.0470588235294118, 0.85)
	-- GUI:PushStyleColor(GUI.Col_ChildWindowBg, , , , )
	-- GUI:PushStyleColor(GUI.Col_Border, , , , )
	-- GUI:PushStyleColor(GUI.Col_BorderShadow, , , , )
	GUI:PushStyleColor(GUI.Col_FrameBg, 0.164705882352941, 0.12156862745098, 0.188235294117647, 0.85)
	GUI:PushStyleColor(GUI.Col_FrameBgHovered, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_FrameBgActive, 0.701960784313725, 0.603921568627451, 0.764705882352941, 0.95)
	GUI:PushStyleColor(GUI.Col_TitleBg, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_TitleBgCollapsed, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_TitleBgActive, 0.164705882352941, 0.12156862745098, 0.188235294117647, 0.85)
	-- GUI:PushStyleColor(GUI.Col_MenuBarBg, , , , )
	GUI:PushStyleColor(GUI.Col_ScrollbarBg, 0.164705882352941, 0.12156862745098, 0.188235294117647, 0.85)
	GUI:PushStyleColor(GUI.Col_ScrollbarGrab, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_ScrollbarGrabHovered, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_ScrollbarGrabActive, 0.701960784313725, 0.603921568627451, 0.764705882352941, 0.95)
	-- GUI:PushStyleColor(GUI.Col_ComboBg, , , , )
	GUI:PushStyleColor(GUI.Col_CheckMark, 0.701960784313725, 0.603921568627451, 0.764705882352941, 0.95)
	GUI:PushStyleColor(GUI.Col_SliderGrab, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.9)
	GUI:PushStyleColor(GUI.Col_SliderGrabActive, 0.701960784313725, 0.603921568627451, 0.764705882352941, 0.95)
	GUI:PushStyleColor(GUI.Col_Button, 0.164705882352941, 0.12156862745098, 0.188235294117647, 0.75)
	GUI:PushStyleColor(GUI.Col_ButtonHovered, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.75)
	GUI:PushStyleColor(GUI.Col_ButtonActive, 0.329411764705882, 0.270588235294118, 0.372549019607843, 1)
	-- GUI:PushStyleColor(GUI.Col_Header, , , , )
	-- GUI:PushStyleColor(GUI.Col_HeaderHovered, , , , )
	-- GUI:PushStyleColor(GUI.Col_HeaderActive, , , , )
	-- GUI:PushStyleColor(GUI.Col_Column, , , , )
	-- GUI:PushStyleColor(GUI.Col_ColumnHovered, , , , )
	-- GUI:PushStyleColor(GUI.Col_ColumnActive, , , , )
	GUI:PushStyleColor(GUI.Col_ResizeGrip, 0.164705882352941, 0.12156862745098, 0.188235294117647, 0.75)
	GUI:PushStyleColor(GUI.Col_ResizeGripHovered, 0.266666666666667, 0.211764705882353, 0.301960784313725, 0.75)
	GUI:PushStyleColor(GUI.Col_ResizeGripActive, 0.329411764705882, 0.270588235294118, 0.372549019607843, 1)
	-- GUI:PushStyleColor(GUI.Col_CloseButton, , , , )
	-- GUI:PushStyleColor(GUI.Col_CloseButtonHovered, , , , )
	-- GUI:PushStyleColor(GUI.Col_CloseButtonActive, , , , )
	-- GUI:PushStyleColor(GUI.Col_PlotLines, , , , )
	-- GUI:PushStyleColor(GUI.Col_PlotLinesHovered, , , , )
	-- GUI:PushStyleColor(GUI.Col_PlotHistogram, , , , )
	-- GUI:PushStyleColor(GUI.Col_PlotHistogramHovered, , , , )
	-- GUI:PushStyleColor(GUI.Col_TextSelectedBg, , , , )
	-- GUI:PushStyleColor(GUI.Col_TooltipBg, , , , )
	-- GUI:PushStyleColor(GUI.Col_ModalWindowDarkening, , , , )
end

function profile.WindowStyleClose()
	GUI:PopStyleColor(20)
end

local GetAction = SkillMgr.GetAction

profile.GCDPriorityTable = {
	[1] = "Refulgent Arrow",
	[2] = "Straight Shot",
	[3] = "DoTs",
	[4] = "Foe Requiem",
	[5] = "Quick Nock",
	[6] = "Heavy Shot"
}
profile.oGCDPriorityTable = {
	[1] = "Raging Strikes",
	[2] = "Barrage",
	[3] = "Pitch Perfect",
	[4] = "Empyreal Arrow",
	[5] = "Sidewinder",
	[6] = "Bloodletter/Rain of Death",
	[7] = "Songs",
	[8] = "Misery's End",
	[9] = "Nature's Minne",
	[10] = "Second Wind",
	[11] = "Palisade",
	[12] = "Battle Voice",
	[13] = "Troubadour",
	[14] = "Invigorate",
	[15] = "Tactician",
	[16] = "Refresh",
	[17] = "The Wardens Paean",
	[18] = "Foot Graze",
	[19] = "Leg Graze",
	[20] = "Head Graze",
	[21] = "Arm Graze",
	[22] = "Potion (DEX)",
	[23] = "Potion (HP)",
	[24] = "Repelling Shot",
	[25] = "Peloton (OOC)"
}
profile.FunctionBL = {
	["Heavy Shot"] = true,
	["Straight Shot"] = true,
	["DoTs"] = true,
	["Quick Nock"] = true,
	["Foe Requiem"] = true,
	["Refulgent Arrow"] = true,
	["Raging Strikes"] = true,
	["Misery's End"] = true,
	["Bloodletter/Rain of Death"] = true,
	["Repelling Shot"] = true,
	["Barrage"] = true,
	["Songs"] = true,
	["Battle Voice"] = true,
	["Pitch Perfect"] = true,
	["Empyreal Arrow"] = true,
	["The Wardens Paean"] = true,
	["Sidewinder"] = true,
	["Troubadour"] = true,
	["Nature's Minne"] = true,
	["Second Wind"] = true,
	["Foot Graze"] = true,
	["Leg Graze"] = true,
	["Peloton (OOC)"] = true,
	["Invigorate"] = true,
	["Tactician"] = true,
	["Refresh"] = true,
	["Head Graze"] = true,
	["Arm Graze"] = true,
	["Palisade"] = true,
	["Potion (DEX)"] = true,
	["Potion (HP)"] = true,
}
profile.AoEGCDPriorityTable = {
	[1] = "Refulgent Arrow",
	[2] = "Straight Shot",
	[3] = "DoTs",
	[4] = "Foe Requiem",
	[5] = "Quick Nock",
	[6] = "Heavy Shot"
}
profile.AoEoGCDPriorityTable = {
	[1] = "Raging Strikes",
	[2] = "Barrage",
	[3] = "Pitch Perfect",
	[4] = "Empyreal Arrow",
	[5] = "Sidewinder",
	[6] = "Bloodletter/Rain of Death",
	[7] = "Songs",
	[8] = "Misery's End",
	[9] = "Nature's Minne",
	[10] = "Second Wind",
	[11] = "Palisade",
	[12] = "Battle Voice",
	[13] = "Troubadour",
	[14] = "Invigorate",
	[15] = "Tactician",
	[16] = "Refresh",
	[17] = "The Wardens Paean",
	[18] = "Foot Graze",
	[19] = "Leg Graze",
	[20] = "Head Graze",
	[21] = "Arm Graze",
	[22] = "Potion (DEX)",
	[23] = "Potion (HP)",
	[24] = "Repelling Shot",
	[25] = "Peloton (OOC)"
}
profile.AoEFunctionBL = {
	["Heavy Shot"] = true,
	["Straight Shot"] = true,
	["DoTs"] = true,
	["Quick Nock"] = true,
	["Foe Requiem"] = true,
	["Refulgent Arrow"] = true,
	["Raging Strikes"] = true,
	["Misery's End"] = true,
	["Bloodletter/Rain of Death"] = true,
	["Repelling Shot"] = true,
	["Barrage"] = true,
	["Songs"] = true,
	["Battle Voice"] = true,
	["Pitch Perfect"] = true,
	["Empyreal Arrow"] = true,
	["The Wardens Paean"] = true,
	["Sidewinder"] = true,
	["Troubadour"] = true,
	["Nature's Minne"] = true,
	["Second Wind"] = true,
	["Foot Graze"] = true,
	["Leg Graze"] = true,
	["Peloton (OOC)"] = true,
	["Invigorate"] = true,
	["Tactician"] = true,
	["Refresh"] = true,
	["Head Graze"] = true,
	["Arm Graze"] = true,
	["Palisade"] = true,
	["Potion (DEX)"] = true,
	["Potion (HP)"] = true,
}


profile.SkillCheck = 0
profile.Skills = {
	HeavyShot = true,
	StraightShot = true,
	VenomousBite = true,
	RagingStrikes = true,
	MiserysEnd = true,
	QuickNock = true,
	Barrage = true,
	Bloodletter = true,
	RepellingShot = true,
	Windbite = true,
	MagesBallad = true,
	FoeRequiem = true,
	ArmysPaeon = true,
	RainOfDeath = true,
	BattleVoice = true,
	EmpyrealArrow = true,
	WanderersMinuet = true,
	IronJaws = true,
	WardensPaean = true,
	Sidewinder = true,
	PitchPerfect = true,
	Troubadour = true,
	CausticBite = true,
	Stormbite = true,
	NaturesMinne = true,
	RefulgentArrow = true,
	SecondWind = true,
	Invigorate = true,
	Palisade = true,
	HeadGraze = true,
	ArmGraze = true,
	FootGraze = true,
	LegGraze = true,
	Tactician = true,
	Refresh = true,
	Peloton = true
}

profile.songs = {
	CurrentSong = 0,
	CurrentOrderStep = 1,
	NextSong = 0,
	SongToggle = true,
	LastChange = 0,
	LastSong = 0,
	Repertoire = 0,
	SongDuration = 0,
	LastCastTime = 0,
	TroubadourSong = 1,
	SongOrder = {    
		[1] = 3,
		[2] = 1,
		[3] = 2
	},
	SongOrderNames= {
		[1] = "The Wanderer's Minuet",
		[2] = "Mage's Ballad",
		[3] = "Army's Paeon"
	},
	SongNumberToIDConversion = {
		[1] = 114,
		[2] = 116,
		[3] = 3559
	},
	SongNumberToNameConversion = {
		[1] = "Mage's Ballad",
		[2] = "Army's Paeon",
		[3] = "The Wanderer's Minuet"
	}
}


profile.oGCD = false

profile.UseOpener = true
profile.OpenerType = 1
profile.opener = false -- false = not ready, true = ready
profile.DoTs = {}
profile.ApplyDoTs = true
profile.DoTMultiEnemies = true
profile.IJMultiEnemies = true
profile.MaxDoTEntities = 5
profile.RefreshDoTs = 8
profile.DoTCurrentTargetOverride = true
profile.DoTLife = 9
profile.MeAnyEnemy = true
profile.MeStep = 0
profile.AoEoocEntities = false
profile.AoETP = 250
profile.LastTarget = 0
profile.Entities = {}
profile.RagingStrikesSong = 3

profile.PelotonOoB = true
profile.PelotonDelay = 1.5
profile.Sprint = true
profile.SprintDelay = 1.5
profile.SprintBattle = false

profile.LastCast = {
	StraightShot = 0,
	CausticBite = {},
	StormBite = {},
	IronJaws = {},
	FoeRequiem = 0,
}

profile.OOCToggle = true
profile.OOCTime = 0
profile.moving = false
profile.MoveStart = 0

profile.PriorityShowAoE = false
profile.CurrentSelection = ""
profile.CurrentAoESelection = ""

profile.DebugGCDTimeTemp = 0
profile.DebugLastGCDTimeTemp = 0
profile.DebugIsGCD = false
profile.DebugGCDTimeTotal = 0
profile.DebugGCDTimeTotalStart = 0
profile.LastLastCast = 0

profile.LastTarget = 0



function profile.Draw()
	local gamestate = GetGameState()
	if (gamestate == FFXIV.GAMESTATE.INGAME) then
		if (profile.GUI.open) then
			profile.WindowStyle()
			profile.GUI.visible, profile.GUI.open = GUI:Begin(profile.GUI.name, profile.GUI.open, GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse)
			if profile.GUI.visible then
				GUI:SetWindowSize(400,460)
				GUI:PushTextWrapPos(0)
				profile.UseOpener = GUI:Checkbox("Use Opener",profile.UseOpener)GUI:SameLine(0,5)GUI:PushStyleColor(GUI.Col_Text,0.66,0.66,0.66,1)GUI:Text("(Not implemented yet as of version 1)")GUI:PopStyleColor()
				GUI:Indent()
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Opener Type:")GUI:SameLine(0,5)profile.OpenerType = GUI:SliderInt("   ",profile.OpenerType,1,3) GUI:PopItemWidth()
				GUI:Unindent()
				profile.ApplyDoTs = GUI:Checkbox("Apply DoTs",profile.ApplyDoTs)
				GUI:Indent()
					profile.DoTMultiEnemies = GUI:Checkbox("Apply DoTs to multiple enemies.",profile.DoTMultiEnemies)
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Number of enemies to maintain DoTs on:")GUI:SameLine(0,5)profile.MaxDoTEntities = GUI:SliderInt(" ",profile.MaxDoTEntities,1,10) GUI:PopItemWidth()
					profile.DoTCurrentTargetOverride = GUI:Checkbox("",profile.DoTCurrentTargetOverride)GUI:SameLine(0,5)GUI:Text("Always apply DoTs to current target, regardless of count.")
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Seconds remaining before reapplying:")GUI:SameLine(0,5)profile.RefreshDoTs = GUI:SliderInt("  ",profile.RefreshDoTs,1,10) GUI:PopItemWidth()
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Stop DoT on enemy at "..string.format("%02d",profile.DoTLife).." seconds left:")GUI:SameLine(0,5)profile.DoTLife = GUI:SliderInt("    ",profile.DoTLife,1,20) GUI:PopItemWidth()
				GUI:Unindent()GUI:Dummy((GUI:GetWindowWidth()-GUI:CalcTextSize("(Not implemented yet as of version 1)"))/2,0)GUI:SameLine(0,0)GUI:PushStyleColor(GUI.Col_Text,0.66,0.66,0.66,1)GUI:Text("(Not implemented yet as of version 1)")GUI:PopStyleColor()
				profile.MeAnyEnemy = GUI:Checkbox("Use Misery's End on any enemy.",profile.MeAnyEnemy)
				profile.AoEoocEntities = GUI:Checkbox("     ",profile.AoEoocEntities)GUI:SameLine(32,0)GUI:Text("Use AoE even if it will aggro additional enemies.")
				profile.PelotonOoB = GUI:Checkbox("      ",profile.PelotonOoB)GUI:SameLine(32,0)GUI:Text("Use Peloton after battle.")
				GUI:Indent()
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Movement Delay in seconds:")GUI:SameLine(0,5)profile.PelotonDelay = GUI:SliderFloat("       ",profile.PelotonDelay,1,20,"%.1f") GUI:PopItemWidth()
				GUI:Unindent()
				profile.Sprint = GUI:Checkbox("        ",profile.Sprint)GUI:SameLine(32,0)GUI:Text("Use Sprint.")
				GUI:Indent()
					GUI:PushItemWidth(75) GUI:AlignFirstTextHeightToWidgets()GUI:Text("Movement Delay in seconds:")GUI:SameLine(0,5)profile.SprintDelay = GUI:SliderFloat("         ",profile.SprintDelay,1,20,"%.1f") GUI:PopItemWidth()
					profile.SprintBattle = GUI:Checkbox("          ",profile.SprintBattle)GUI:SameLine(52,0)GUI:Text("Only use Sprint while in battle.")
				GUI:Unindent()
				GUI:NewLine()
				GUI:Dummy(100,0)GUI:SameLine(0,0)
				if GUI:SmallButton("Change Skill Priorities") then profile.PriorityGUI.open = not profile.PriorityGUI.open end
				GUI:Dummy(80,0)GUI:SameLine(0,0)
				if GUI:SmallButton("Open Discord") then
					io.popen(GetLuaModsPath()..[[ACR\CombatRoutines\Discord.url]])
				end
				GUI:SameLine(0,5)
				if GUI:SmallButton("Open Forum Topic") then
					io.popen(GetLuaModsPath()..[[ACR\CombatRoutines\ForumTopic.url]])
				end



				GUI:PopTextWrapPos()
			end
			GUI:End()
			profile.WindowStyleClose()
		end
		if (profile.PriorityGUI.open) then
			profile.WindowStyle()
			profile.PriorityGUI.visible, profile.PriorityGUI.open = GUI:Begin(profile.PriorityGUI.name, profile.PriorityGUI.open, GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse)
			if profile.GUI.visible then
				GUI:SetWindowSize(505,410)
				GUI:Dummy(0,20)
					GUI:PushItemWidth(225)
					if profile.PriorityShowAoE then
						GUI:ListBoxHeader("##GCD",table.size(profile.AoEGCDPriorityTable),20)
						for k,v in table.pairsbykeys(profile.AoEGCDPriorityTable) do
							local selected = false
							if profile.CurrentAoESelection == v then selected = true else selected = false end
							profile.FunctionBL[v] = GUI:Checkbox("##"..v,profile.FunctionBL[v])GUI:SameLine(0,2)c = GUI:Selectable(v,selected)
							if GUI:IsItemClicked(c) then profile.CurrentAoESelection = v end
						end
						GUI:ListBoxFooter()
					else
						GUI:ListBoxHeader("##GCD",table.size(profile.GCDPriorityTable),20)
						for k,v in table.pairsbykeys(profile.GCDPriorityTable) do
							local selected = false
							if profile.CurrentSelection == v then selected = true else selected = false end
							profile.FunctionBL[v] = GUI:Checkbox("##"..v,profile.FunctionBL[v])GUI:SameLine(0,2)c = GUI:Selectable(v,selected)
							if GUI:IsItemClicked(c) then profile.CurrentSelection = v end
						end
						GUI:ListBoxFooter()
					end
					GUI:PopItemWidth()
				GUI:SameLine(0,0)
				GUI:BeginChild("Buttons",40,-1,false)
					GUI:Dummy(3,0)GUI:SameLine(0,0)GUI:Text("Raise")
					GUI:Dummy(4,0)GUI:SameLine(0,0)c = GUI:ImageButton("Move Up",GetStartupPath()..[[\GUI\UI_Textures\collapse.png]],25,25)
					if GUI:IsItemClicked(c) then
						if profile.PriorityShowAoE then
							if table.contains(profile.AoEGCDPriorityTable,profile.CurrentAoESelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.AoEGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key-1)>=1 then
									keylowertext = profile.AoEGCDPriorityTable[key-1]
									profile.AoEGCDPriorityTable[key] = keylowertext
									profile.AoEGCDPriorityTable[key-1] = keytext
								end
							elseif table.contains(profile.AoEoGCDPriorityTable,profile.CurrentAoESelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.AoEoGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key-1)>=1 then
									keylowertext = profile.AoEoGCDPriorityTable[key-1]
									profile.AoEoGCDPriorityTable[key] = keylowertext
									profile.AoEoGCDPriorityTable[key-1] = keytext
								end
							end
						else
							if table.contains(profile.GCDPriorityTable,profile.CurrentSelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.GCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key-1)>=1 then
									keylowertext = profile.GCDPriorityTable[key-1]
									profile.GCDPriorityTable[key] = keylowertext
									profile.GCDPriorityTable[key-1] = keytext
								end
							elseif table.contains(profile.oGCDPriorityTable,profile.CurrentSelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.oGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key-1)>=1 then
									keylowertext = profile.oGCDPriorityTable[key-1]
									profile.oGCDPriorityTable[key] = keylowertext
									profile.oGCDPriorityTable[key-1] = keytext
								end
							end
						end
					end
					GUI:Dummy(4,0)GUI:SameLine(0,0)c = GUI:ImageButton("Move Down",GetStartupPath()..[[\GUI\UI_Textures\expand.png]],25,25)
					if GUI:IsItemClicked(c) then
						if profile.PriorityShowAoE then
							if table.contains(profile.AoEGCDPriorityTable,profile.CurrentAoESelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.AoEGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key+1)<=table.size(profile.AoEGCDPriorityTable) then
									keyhighertext = profile.AoEGCDPriorityTable[key+1]
									profile.AoEGCDPriorityTable[key] = keyhighertext
									profile.AoEGCDPriorityTable[key+1] = keytext
								end
							elseif table.contains(profile.AoEoGCDPriorityTable,profile.CurrentAoESelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.AoEoGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key+1)<=table.size(profile.AoEoGCDPriorityTable) then
									keyhighertext = profile.AoEoGCDPriorityTable[key+1]
									profile.AoEoGCDPriorityTable[key] = keyhighertext
									profile.AoEoGCDPriorityTable[key+1] = keytext
								end
							end
						else
							if table.contains(profile.GCDPriorityTable,profile.CurrentSelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.GCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key+1)<=table.size(profile.GCDPriorityTable) then
									keyhighertext = profile.GCDPriorityTable[key+1]
									profile.GCDPriorityTable[key] = keyhighertext
									profile.GCDPriorityTable[key+1] = keytext
								end
							elseif table.contains(profile.oGCDPriorityTable,profile.CurrentSelection) then
								local key = 0
								local keytext = ""
								local keylowertext = ""
								local keyhighertext = ""
								for k,v in table.pairsbykeys(profile.oGCDPriorityTable) do
									if v == profile.CurrentSelection then key = k keytext = v end
								end
								if (key+1)<=table.size(profile.oGCDPriorityTable) then
									keyhighertext = profile.oGCDPriorityTable[key+1]
									profile.oGCDPriorityTable[key] = keyhighertext
									profile.oGCDPriorityTable[key+1] = keytext
								end
							end
						end
					end
					GUI:Dummy(4,0)GUI:SameLine(0,0)GUI:Text("Lower")
				GUI:EndChild()
				GUI:SameLine(0,0)
					GUI:PushItemWidth(225)
					if profile.PriorityShowAoE then
						GUI:ListBoxHeader("##AoEoGCD",table.size(profile.AoEoGCDPriorityTable),20)
						for k,v in table.pairsbykeys(profile.AoEoGCDPriorityTable) do
							local selected = false
							if profile.CurrentAoESelection == v then selected = true else selected = false end
							profile.FunctionBL[v] = GUI:Checkbox("##"..v,profile.FunctionBL[v])GUI:SameLine(0,2)c = GUI:Selectable(v,selected)
							if GUI:IsItemClicked(c) then profile.CurrentAoESelection = v end
						end
						GUI:ListBoxFooter()
					else
						GUI:ListBoxHeader("##oGCD",table.size(profile.oGCDPriorityTable),20)
						for k,v in table.pairsbykeys(profile.oGCDPriorityTable) do
							local selected = false
							if profile.CurrentSelection == v then selected = true else selected = false end
							profile.FunctionBL[v] = GUI:Checkbox("##"..v,profile.FunctionBL[v])GUI:SameLine(0,2)c = GUI:Selectable(v,selected)
							if GUI:IsItemClicked(c) then profile.CurrentSelection = v end
						end
						GUI:ListBoxFooter()
					end
					GUI:PopItemWidth()
			end
			GUI:End()
			profile.WindowStyleClose()
		end
		if (profile.DebugGUI.open) then
			profile.WindowStyle()
			profile.DebugGUI.visible, profile.DebugGUI.open = GUI:Begin(profile.DebugGUI.name, profile.DebugGUI.open, GUI.WindowFlags_NoResize + GUI.WindowFlags_NoScrollbar + GUI.WindowFlags_NoScrollWithMouse + GUI.WindowFlags_NoCollapse)
			if profile.DebugGUI.visible then
				GUI:SetWindowSize(600,1000)
				if not SkillMgr.GetAction(97).isoncd and Player.incombat and Player:GetTarget()~=nil then
					if not profile.DebugIsGCD then
						profile.DebugGCDTimeTemp = Now()
						profile.DebugIsGCD = true
					end
				elseif SkillMgr.GetAction(97).isoncd and Player.incombat and Player:GetTarget()~=nil then
					profile.DebugIsGCD = false
					if profile.DebugGCDTimeTotal == 0 then profile.DebugGCDTimeTotal = Now() profile.DebugGCDTimeTotalStart = profile.DebugGCDTimeTotal end
					if profile.DebugGCDTimeTemp ~= profile.DebugLastGCDTimeTemp then
						if (profile.DebugGCDTimeTotal + TimeSince(profile.DebugGCDTimeTemp)) == (profile.DebugGCDTimeTotalStart + TimeSince(profile.DebugGCDTimeTemp)) then
							profile.DebugGCDTimeTotal = (profile.DebugGCDTimeTotal - profile.DebugGCDTimeTotalStart) + TimeSince(profile.DebugGCDTimeTemp)
						else
							profile.DebugGCDTimeTotal = profile.DebugGCDTimeTotal + TimeSince(profile.DebugGCDTimeTemp)
						end
						profile.DebugLastGCDTimeTemp = profile.DebugGCDTimeTemp
					end
				end
				GUI:Text("Time Wasted Sitting in GCD: "..(profile.DebugGCDTimeTotal/1000))
				GUI:Text("oGCD: "..tostring(profile.oGCD))
				GUI:Text("DoTs Size: "..table.size(profile.DoTs))
				GUI:Text("Misery's End Step: "..profile.MeStep.." ")GUI:SameLine(0,0)
				
				if Player:GetTarget()~=nil then
					GUI:Text("Current Target: "..Player:GetTarget().name.." ["..Player:GetTarget().id.."]")
				end
				GUI:Text("Current Song: "..profile.songs.CurrentSong.." Current Song Order Step: "..profile.songs.CurrentOrderStep)
				GUI:Text("Moving?: "..tostring(Player:IsMoving()).." Time Since: ")GUI:SameLine(0,0)
				if Player:IsMoving() then GUI:Text(TimeSince(profile.MoveStart)) else GUI:Text("0") end
				GUI:NewLine()
				if GUI:TreeNode("Actions - Is on Cooldown Check") then
					for id, action in pairs(ActionList:Get(1)) do
						if action.usable and not In(id,1568,1580,1582,1583,1584,1585,1590,4249,8834,8835,8836,8837,8838,8839,8841,8842,8843,8844,8925,9624,9625,9626) and (action.job == 5 or action.job == 23 or action.job == 255) then
							c = GUI:Text(action.name.." \["..id.."\] - ")GUI:SameLine(0,0)
							if action.isoncd then
								GUI:PushStyleColor(GUI.Col_Text,1,0,0,1)
								GUI:Text("Not Ready")
								GUI:PopStyleColor()
							else
								GUI:PushStyleColor(GUI.Col_Text,0,1,0,1)
								GUI:Text("Ready")
								GUI:PopStyleColor()
							end
							if GUI:IsItemClicked(c) then
								local target = Player:GetTarget()
								if target then
									action:Cast(target.id)
								else
									action:Cast()
								end
							end
						end
					end
				end
			end
			GUI:End()
			profile.WindowStyleClose()
		end
	end
end

function profile.Cast()
	if profile.GUI.debug then
		ml_gui.showconsole = true
		profile.GUI.open = true
		profile.DebugGUI.open = true
	end
	local currentTarget = MGetTarget()
    local CurrentSong = profile.songs.CurrentSong
    local Repertoire = profile.songs.Repertoire
    local SongDuration = profile.songs.SongDuration
    local CurrentOrderStep = profile.songs.CurrentOrderStep
    local NextSong = profile.songs.NextSong

	-- Begin Skill Check --
		
		if TimeSince(profile.SkillCheck) > 30000 then
			profile.Skills.HeavyShot = GetAction(97)~=nil
			profile.Skills.StraightShot = GetAction(98)~=nil
			profile.Skills.VenomousBite = GetAction(100)~=nil
			profile.Skills.RagingStrikes = GetAction(101)~=nil
			profile.Skills.MiserysEnd = GetAction(103)~=nil
			profile.Skills.QuickNock = GetAction(106)~=nil
			profile.Skills.Barrage = GetAction(107)~=nil
			profile.Skills.Bloodletter = GetAction(110)~=nil
			profile.Skills.RepellingShot = GetAction(112)~=nil
			profile.Skills.Windbite = GetAction(113)~=nil
			profile.Skills.MagesBallad = GetAction(114)~=nil
			profile.Skills.FoeRequiem = GetAction(115)~=nil
			profile.Skills.ArmysPaeon = GetAction(116)~=nil
			profile.Skills.RainOfDeath = GetAction(117)~=nil
			profile.Skills.BattleVoice = GetAction(118)~=nil
			profile.Skills.EmpyrealArrow = GetAction(3558)~=nil
			profile.Skills.WanderersMinuet = GetAction(3559)~=nil
			profile.Skills.IronJaws = GetAction(3560)~=nil
			profile.Skills.WardensPaean = GetAction(3561)~=nil
			profile.Skills.Sidewinder = GetAction(3562)~=nil
			profile.Skills.PitchPerfect = GetAction(7404)~=nil
			profile.Skills.Troubadour = GetAction(7405)~=nil
			profile.Skills.CausticBite = GetAction(7406)~=nil
			profile.Skills.Stormbite = GetAction(7407)~=nil
			profile.Skills.NaturesMinne = GetAction(7408)~=nil
			profile.Skills.RefulgentArrow = GetAction(7409)~=nil
			profile.Skills.SecondWind = GetAction(7541)~=nil
			profile.Skills.Invigorate = GetAction(7544)~=nil
			profile.Skills.Palisade = GetAction(7550)~=nil
			profile.Skills.HeadGraze = GetAction(7551)~=nil
			profile.Skills.ArmGraze = GetAction(7552)~=nil
			profile.Skills.FootGraze = GetAction(7553)~=nil
			profile.Skills.LegGraze = GetAction(7554)~=nil
			profile.Skills.Tactician = GetAction(7555)~=nil
			profile.Skills.Refresh = GetAction(7556)~=nil
			profile.Skills.Peloton = GetAction(7557)~=nil
			profile.SkillCheck = Now()
		end
		local HeavyShot = profile.Skills.HeavyShot
		local StraightShot = profile.Skills.StraightShot
		local VenomousBite = profile.Skills.VenomousBite
		local RagingStrikes = profile.Skills.RagingStrikes
		local MiserysEnd = profile.Skills.MiserysEnd
		local QuickNock = profile.Skills.QuickNock
		local Barrage = profile.Skills.Barrage
		local Bloodletter = profile.Skills.Bloodletter
		local RepellingShot = profile.Skills.RepellingShot
		local Windbite = profile.Skills.Windbite
		local MagesBallad = profile.Skills.MagesBallad
		local FoeRequiem = profile.Skills.FoeRequiem
		local ArmysPaeon = profile.Skills.ArmysPaeon
		local RainOfDeath = profile.Skills.RainOfDeath
		local BattleVoice = profile.Skills.BattleVoice
		local EmpyrealArrow = profile.Skills.EmpyrealArrow
		local WanderersMinuet = profile.Skills.WanderersMinuet
		local IronJaws = profile.Skills.IronJaws
		local WardensPaean = profile.Skills.WardensPaean
		local Sidewinder = profile.Skills.Sidewinder
		local PitchPerfect = profile.Skills.PitchPerfect
		local Troubadour = profile.Skills.Troubadour
		local CausticBite = profile.Skills.CausticBite
		local Stormbite = profile.Skills.Stormbite
		local NaturesMinne = profile.Skills.NaturesMinne
		local RefulgentArrow = profile.Skills.RefulgentArrow
		local SecondWind = profile.Skills.SecondWind
		local Invigorate = profile.Skills.Invigorate
		local Palisade = profile.Skills.Palisade
		local HeadGraze = profile.Skills.HeadGraze
		local ArmGraze = profile.Skills.ArmGraze
		local FootGraze = profile.Skills.FootGraze
		local LegGraze = profile.Skills.LegGraze
		local Tactician = profile.Skills.Tactician
		local Refresh = profile.Skills.Refresh
		local Peloton = profile.Skills.Peloton
	-- End Skill Check --

	-- Begin oGCD Detection --
		if GetAction(97).isoncd and (GetAction(97).cd <= (GetAction(97).recasttime - 0.90)) then
			profile.oGCD = true
		else
			profile.oGCD = false
		end
	-- End oGCD Detection --

	-- Song Detection --
		local g = Player.gauge
		if (table.valid(g)) then
			for i,k in pairs (g) do
				if i == 1 and k == 5 then
					profile.songs.CurrentSong = 1
				elseif i == 1 and k == 10 then
					profile.songs.CurrentSong = 2
				elseif i == 1 and k == 15 then
					profile.songs.CurrentSong = 3
				elseif i == 1 then
					profile.songs.CurrentSong = 0
				end
				if i == 2 then profile.songs.Repertoire = k end
				if i == 3 then profile.songs.SongDuration = k end
			end							
		end
		if profile.songs.LastSong ~= profile.songs.CurrentSong and SongToggle then
			SongToggle = false
			profile.songs.LastSong = profile.songs.CurrentSong
			profile.songs.LastChange = Now()
		end
		if TimeSince(profile.songs.LastChange) > 5000 then
			SongToggle = true
		end
    -- End Song Detection --

    -- Begin DoT Detection --
    	if VenomousBite then
    		local t = {}
			local el = EntityList("type=2,attackable,alive,maxdistance=50")
			if table.valid(el) then
				for i,e in pairs(el) do
					if i~=nil and e~=nil then
						if e.distance <= (25 + e.hitradius) and e.targetable then
							if t[e.id] == nil then t[e.id] = true else t[e.id] = true end
							if e.incombat then
								for a,b in pairs(e.buffs) do
									if b.ownerid == Player.id and (b.id==124 or b.id==129 or b.id==1200 or b.id==1201) then
										if profile.DoTs[e.id] == nil then profile.DoTs[e.id] = {} end
										if profile.DoTs[e.id][b.id] == nil then profile.DoTs[e.id][b.id] = b.duration else profile.DoTs[e.id][b.id] = b.duration end
									end
								end
							end
						end
					end
				end
			end
			for k,v in pairs(profile.DoTs) do
				if t[k] == nil then profile.DoTs[k] = nil end
				if table.size(v)==0 then profile.DoTs[k] = nil end
				for i,e in pairs(v) do
					if not HasBuffs(EntityList:Get(k),i,0,Player.id) then profile.DoTs[k][i] = nil end
				end
			end
		end
	-- End DoT Detection --

	if Player:IsMoving() and profile.moving == false then
    	profile.MoveStart = Now()
    	profile.moving = true
    elseif not Player:IsMoving() and profile.moving == true then
    	profile.moving = false
    end

	local function UseGetLastCast()
		local LastCast = Player.castinginfo.lastcastid
		local LastTarget = profile.LastTarget
		local CastingID = Player.castinginfo.castingid
		local ct = Player.castinginfo.castingtargets
		if table.size(ct) > 0 then
			for tid,target in pairs(ct) do
				if CastingID~=8 and tid==1 then
					LastTarget = target
				end
			end
		end
		if LastCast ~= profile.LastLastCast then
			if CastingID==98 then profile.LastCast.StraightShot = Now() end
			if CastingID==100 then profile.LastCast.CausticBite[LastTarget] = Now() end
			if CastingID==7406 then profile.LastCast.CausticBite[LastTarget] = Now() end
			if CastingID==113 then profile.LastCast.StormBite[LastTarget] = Now() end
			if CastingID==7407 then profile.LastCast.StormBite[LastTarget] = Now() end
			if CastingID==3560 then profile.LastCast.IronJaws[LastTarget] = Now() end
			if CastingID==115 then profile.LastCast.FoeRequiem = Now() end
			if LastCast==114 then profile.songs.LastCastTime = Now() end
			if LastCast==116 then profile.songs.LastCastTime = Now() end
			if LastCast==3559 then profile.songs.LastCastTime = Now() end
			profile.LastLastCast = LastCast
		end
	end
	UseGetLastCast()

	local function UseOocTimer()
		if Player.incombat == false and profile.OOCToggle then
			profile.OOCTime = Now()
			profile.OOCToggle = false
		elseif Player.incombat and profile.OOCToggle == false then
			profile.OOCToggle = true
		end
	end
	UseOocTimer()


	local function UseHeavyShot()
		GetAction(97):Cast(currentTarget.id)
	end
		
	local function UseStraightShot()
		if StraightShot then
			if MissingBuffs(Player,"128+130",4,Player.id) and TimeSince(profile.LastCast.StraightShot) > 3000 then
				GetAction(98):Cast(currentTarget.id)
			end
		end
	end

	local function UseDoTs()
		d("test1")
		if profile.ApplyDoTs then
		d("test2")
			local el = EntityList("type=2,incombat,attackable,alive,maxdistance=50")
		d("test3")
			if table.valid(el) then
		d("test4")
				for i,e in pairs(el) do
					if e.distance <= (25 + e.hitradius) and e.targetable then -- Max Range for attacks towards enemy targets, plus the enemy's hit radius. ONLY entities that are in combat.
		d("test5")
						if profile.DoTCurrentTargetOverride then
							if Windbite and MissingBuffs(Player:GetTarget(),"129+1201",0,Player.id) then
								if profile.LastCast.StormBite[Player:GetTarget().id]~=nil then if TimeSince(profile.LastCast.StormBite[Player:GetTarget().id]) > 3000 then
								GetAction(113):Cast(Player:GetTarget().id) end else GetAction(113):Cast(Player:GetTarget().id) end
							elseif VenomousBite and MissingBuffs(Player:GetTarget(),"129+1201",0,Player.id) then
								if profile.LastCast.CausticBite[Player:GetTarget().id]~=nil then if TimeSince(profile.LastCast.CausticBite[Player:GetTarget().id]) > 3000 then
								GetAction(100):Cast(Player:GetTarget().id) end else GetAction(100):Cast(Player:GetTarget().id) end
							end
						end
						for k,v in pairs(profile.DoTs) do
							if Windbite and MissingBuffs(EntityList:Get(k),"129+1201",0,Player.id) then
							if profile.LastCast.StormBite[k]~=nil then if TimeSince(profile.LastCast.StormBite[k]) > 3000 then
								GetAction(113):Cast(k) end else GetAction(113):Cast(k) end
							end
							if VenomousBite and MissingBuffs(EntityList:Get(k),"124+1200",0,Player.id) then
							if profile.LastCast.CausticBite[k]~=nil then if TimeSince(profile.LastCast.CausticBite[k]) > 3000 then
								GetAction(100):Cast(k) end else GetAction(100):Cast(k) end
							end
							if IronJaws and HasBuffs(EntityList:Get(k),"124+129,1200+1201",profile.RefreshDoTs,Player.id) then else
							if profile.LastCast.IronJaws[k]~=nil then if TimeSince(profile.LastCast.IronJaws[k]) > 3000 then
								GetAction(3560):Cast(k) end else GetAction(3560):Cast(k) end
							end
						end
						if profile.DoTMultiEnemies and (table.size(profile.DoTs) < profile.MaxDoTEntities) then -- Checking if you have met the Max Dot'ed Entity cap yet or not
							HighestHpEntity = 0
							HighestHpEntityHP = 0
							if e.hp.current > HighestHpEntityHP and profile.DoTs[e.id] == nil then HighestHpEntity = e.id; HighestHpEntityHP = e.hp.current end
							if Windbite then if profile.LastCast.StormBite[HighestHpEntity]~=nil then if TimeSince(profile.LastCast.StormBite[HighestHpEntity]) > 3000 then
								GetAction(113):Cast(HighestHpEntity) end else GetAction(113):Cast(HighestHpEntity) end
							elseif VenomousBite then if profile.LastCast.CausticBite[HighestHpEntity]~=nil then if TimeSince(profile.LastCast.CausticBite[HighestHpEntity]) > 3000 then
								GetAction(100):Cast(HighestHpEntity) end else GetAction(100):Cast(HighestHpEntity) end
							end
						end
					end
				end
			end
		end
	end

	local function UseQuickNock()
		if QuickNock and GetAction(106):IsReady(Player:GetTarget().id) and Player.tp > profile.AoETP then
			local el = EntityList("type=2,alive,attackable,maxdistance=50")
			if table.valid(el) then
				local EntitiesInRange = {}
				local EntitiesInRange2 = {}
				local EntitiesInRange3 = {}
				local bestTarget = 0
				local TargetCount = 0
				for i,e in pairs(el) do
					if i~=nil and e~=nil then
						if e.distance <= (12 + e.hitradius) and e.targetable then
							if EntitiesInRange[e.id] == nil then EntitiesInRange[e.id] = e.incombat else EntitiesInRange[e.id] = e.incombat end
							if EntitiesInRange2[e.id] == nil then EntitiesInRange2[e.id] = e.incombat else EntitiesInRange[e.id] = e.incombat end
						end
					end
				end
				if profile.AoEoocEntities then -- You're not limited to pick an enemy to target with other entities around it that are not in combat
					for a,b in pairs(EntitiesInRange) do
						for c,e in pairs(EntitiesInRange2) do
							local entity1 = a
							local entity2 = c
							local P1 = Player.pos.x
							local P2 = Player.pos.z
							local Q1a = EntityList:Get(entity1).pos.x
							local Q2a = EntityList:Get(entity1).pos.z
							local Q1b = EntityList:Get(entity2).pos.x
							local Q2b = EntityList:Get(entity2).pos.z
							local PQ1 = math.sqrt(math.pow(Q1a-P1,2) + math.pow(Q2a-P2,2))
							local PQ2 = math.sqrt(math.pow(Q1b-P1,2) + math.pow(Q2b-P2,2))
							local DOT = ((Q1a-P1)*(Q1b-P1))+((Q2a-P2)*(Q2b-P2))
							local Angle = math.deg(math.acos(DOT/(PQ1*PQ2)))
							if a~=c and Angle~=nil and Angle <= 40 then
								if EntitiesInRange3[a] == nil then EntitiesInRange3[a] = 0 end
								EntitiesInRange3[a] = EntitiesInRange3[a] + 1
							end
						end
					end
					for i,e in pairs(EntitiesInRange3) do
						if e > TargetCount then
							bestTarget = i
							TargetCount = e
						end
					end
					if bestTarget ~= 0 then
						profile.PriorityShowAoE = true
						GetAction(106):Cast(bestTarget)
					else
						profile.PriorityShowAoE = false
					end
				else -- Filter entities until you find a target without any entity around it that isn't in combat. Everything that will be hit must already be aggroed.
					for a,b in pairs(EntitiesInRange) do
						for c,e in pairs(EntitiesInRange2) do
							local entity1 = a
							local entity2 = c
							local P1 = Player.pos.x
							local P2 = Player.pos.z
							local Q1a = EntityList:Get(entity1).pos.x
							local Q2a = EntityList:Get(entity1).pos.z
							local Q1b = EntityList:Get(entity2).pos.x
							local Q2b = EntityList:Get(entity2).pos.z
							local PQ1 = math.sqrt(math.pow(Q1a-P1,2) + math.pow(Q2a-P2,2))
							local PQ2 = math.sqrt(math.pow(Q1b-P1,2) + math.pow(Q2b-P2,2))
							local DOT = ((Q1a-P1)*(Q1b-P1))+((Q2a-P2)*(Q2b-P2))
							local Angle = math.deg(math.acos(DOT/(PQ1*PQ2)))
							if a~=c and a~=false and c~=false and Angle~=nil and Angle <= 40 then
								if EntitiesInRange3[a] == nil then EntitiesInRange3[a] = 0 end
								EntitiesInRange3[a] = EntitiesInRange3[a] + 1
							end
						end
					end
					for i,e in pairs(EntitiesInRange3) do
						if e > TargetCount then
							bestTarget = i
							TargetCount = e
						end
					end
					if bestTarget ~= 0 then
						profile.PriorityShowAoE = true
						GetAction(106):Cast(bestTarget)
					else
						profile.PriorityShowAoE = false
					end
				end
			else
				profile.PriorityShowAoE = false
			end
		else
			profile.PriorityShowAoE = false
		end
	end

	local function UseFoeRequiem()
		if FoeRequiem and Player.incombat and SongDuration >= 4000 and Player.mp.percent >= 50 and MissingBuffs(Player,"139",0,Player.id) and TimeSince(profile.LastCast.FoeRequiem) >= 3000 and not Player:IsMoving() and not (CurrentSong == 3 and Repertoire >= 2) then
			if RefulgentArrow and not GetAction(7409):IsReady(Player:GetTarget().id) then
				GetAction(115):Cast()
			end
		elseif HasBuffs(Player,"139",0,Player.id) and Player.incombat and SongDuration >= 4000 and TimeSince(profile.LastCast.FoeRequiem) >= 3000 and not Player:IsMoving() and not (CurrentSong == 3 and Repertoire >= 2) then
			local el = EntityList("myparty,alive,maxdistance=50")
			if table.valid(el) then
				for i,e in pairs(el) do
					if HasBuffs(e,"139") then
						GetAction(115):Cast()
					end
				end
			end
		end
		if HasBuffs(Player,"139",0,Player.id) and not Player.incombat and TimeSince(profile.OOCTime) >= 3000 and TimeSince(profile.LastCast.FoeRequiem) >= 3000 and not Player:IsMoving() then
			GetAction(115):Cast()
		end
	end

	local function UseRefulgentArrow()
		if RefulgentArrow then
			if HasBuffs(Player,"122+128",0,Player.id) or (HasBuffs(Player,"122",0,Player.id) and MissingBuffs(Player,"122",(GetAction(107).recasttime - GetAction(107).cd),Player.id))then
				GetAction(7409):Cast(currentTarget.id)
			end
		end
	end

	local function UseRagingStrikes()
		if CurrentSong==profile.RagingStrikesSong then -- TODO: Delay Raging Strikes a few seconds for a late Barrage within the song.
			GetAction(101):Cast()
		end
	end

	local function UseMiserysEnd()
		if profile.MeAnyEnemy then
			local el = EntityList("type=2,incombat,alive,attackable,aggro,maxdistance=50")
			if table.valid(el) then
				local entityid = 0
				local entityhp = 0
				local t = {}
				for i,e in pairs(el) do
					if e.distance <= (25 + e.hitradius) and e.targetable and e.hp.percent <= 20 then -- filtering all enemies to only those who have 20% HP or less
						if t[e.id] == nil then t[e.id] = true end
						if e.hp.current >= entityhp then
							entityhp = e.hp.current
							entityid = e.id
						end
					end
				end
				if profile.MeStep == 0 and (GetAction(103).cdmax - GetAction(103).cd) <= 500 then -- Begin process
					profile.LastTarget = Player:GetTarget().id
					Player:SetTarget(entityid)
					profile.MeStep = 1
				end
				if profile.MeStep == 1 and not GetAction(103).isoncd then
					Player:SetTarget(entityid)
					GetAction(103):Cast(currentTarget.id)
				elseif profile.MeStep == 1 and GetAction(103).isoncd and GetAction(103).cd >= 1 then
					Player:SetTarget(profile.LastTarget)
					profile.MeStep = 0
				end
			end
		end
	end

	local function UseRainOfDeath()
		if RainOfDeath and not GetAction(117).isoncd then
			local el = EntityList("type=2,alive,attackable,maxdistance=50")
			if table.valid(el) then
				local EntitiesInRange = {}
				local EntitiesInRange2 = {}
				local EntitiesInRange3 = {}
				local bestTarget = 0
				local TargetCount = 0
				for i,e in pairs(el) do
					if e.distance <= (25 + e.hitradius + 8) and e.targetable then
						if EntitiesInRange[e.id] == nil then EntitiesInRange[e.id] = e.incombat else EntitiesInRange[e.id] = e.incombat end
						if EntitiesInRange2[e.id] == nil then EntitiesInRange2[e.id] = e.incombat else EntitiesInRange[e.id] = e.incombat end
					end
				end
				if profile.AoEoocEntities then -- You're not limited to pick an enemy to target with other entities around it that are not in combat
					for a,b in pairs(EntitiesInRange) do
						if a~=nil and b~= nil then
							for c,e in pairs(EntitiesInRange2) do
								if c~=nil and e~= nil then
									if a~=c and math.distance3d(EntityList:Get(a).pos,EntityList:Get(c).pos) <= 8 then
										if EntitiesInRange3[a] == nil then EntitiesInRange3[a] = 0 end
										EntitiesInRange3[a] = EntitiesInRange3[a] + 1
									end
								end
							end
						end
					end
					for i,e in pairs(EntitiesInRange3) do
						if i~=nil and e~=nil then
							if e > TargetCount then
								bestTarget = i
								TargetCount = e
							end
						end
					end
					if bestTarget ~= 0 then
						GetAction(117):Cast(bestTarget)
					else
						GetAction(110):Cast(currentTarget.id)
					end
				else -- You must filter entities until you find a target without any entity around it that isn't in combat. Everything that will be hit must already be aggroed.
					for a,b in pairs(EntitiesInRange) do
						if a~=nil and b~= nil then
							for c,e in pairs(EntitiesInRange2) do
								if c~=nil and e~= nil then
									if a~=c and (a~=false) and (c~=false) and math.distance3d(EntityList:Get(a).pos,EntityList:Get(c).pos) <= 8 then
										if EntitiesInRange3[a] == nil then EntitiesInRange3[a] = 0 end
										EntitiesInRange3[a] = EntitiesInRange3[a] + 1
									end
								end
							end
						end
					end
					for i,e in pairs(EntitiesInRange3) do
						if i~=nil and e~=nil then
							if e > TargetCount then
								bestTarget = i
								TargetCount = e
							end
						end
					end
					if bestTarget ~= 0 then
						GetAction(117):Cast(bestTarget)
					else
						GetAction(110):Cast(currentTarget.id)
					end
				end
			end
		elseif not RainOfDeath and Bloodletter then
			GetAction(110):Cast(currentTarget.id)
		end
	end

	local function UseRepellingShot()
		-- TODO... but probably not.
	end

	local function UseBarrage()
		if Barrage and GetAction(107):IsReady() then
			if CurrentSong == 3 and not GetAction(101):IsReady() then
				GetAction(107):Cast()
			elseif CurrentSong ~= 3 then
				GetAction(107):Cast()
			end
		end
	end

	local function UseSongs()
		local SongNumberToNilConverstion = {
			[1] = MagesBallad,
			[2] = ArmysPaeon,
			[3] = WanderersMinuet
		}
		for k,v in pairs(profile.songs.SongOrder) do
				if v == CurrentSong then CurrentOrderStep = k end
			end
		if TimeSince(profile.songs.LastCastTime) > 5000 and TimeSince(profile.songs.LastCastTime) < 80000 then
			if (CurrentOrderStep + 1) == 4 then NextSong = 1 else NextSong = CurrentOrderStep + 1 end
			if CurrentSong == 0 and SongDuration == 0 then
				if SongNumberToNilConverstion[profile.songs.SongOrder[1]] and GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[1]]):IsReady(currentTarget.id) then
					GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[1]]):Cast(currentTarget.id)
				elseif SongNumberToNilConverstion[profile.songs.SongOrder[2]] and GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[2]]):IsReady(currentTarget.id) then
					GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[2]]):Cast(currentTarget.id)
				elseif SongNumberToNilConverstion[profile.songs.SongOrder[3]] and GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[3]]):IsReady(currentTarget.id) then
					GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[3]]):Cast(currentTarget.id)
				end
			elseif CurrentSong == 1 and SongToggle then -- Mage's Ballad Logic
				if SongDuration <= 3000 then
					GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[NextSong]]):Cast(currentTarget.id)
				end
			elseif CurrentSong == 2 and SongToggle then -- Army's Paeon Logic
				if SongNumberToNilConverstion[profile.songs.SongOrder[NextSong]] and GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[NextSong]]):IsReady(currentTarget.id) then
					if SongDuration <= 24000 and Repertoire == 5 then
						GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[NextSong]]):Cast(currentTarget.id)
					elseif SongDuration <= 10000 then
						GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[NextSong]]):Cast(currentTarget.id)
					end
				end
			elseif CurrentSong == 3 and SongToggle then -- The Wanderer's Minuet Logic
				if SongDuration <= 3000 then
					GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[NextSong]]):Cast(currentTarget.id)
				end
			end
		elseif TimeSince(profile.songs.LastCastTime) > 80000 then
			if SongNumberToNilConverstion[profile.songs.SongOrder[1]] and GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[1]]):IsReady(currentTarget.id) then
				GetAction(profile.songs.SongNumberToIDConversion[profile.songs.SongOrder[1]]):Cast(currentTarget.id)
			end
		end
	end

	local function UseBattleVoice()
		if BattleVoice and CurrentSong ~= 0 and GetAction(118):IsReady() then
			local DPSsize = 0
			local DPSNear = 0
			local el = EntityList("myparty,incombat,alive,maxdistance=50")
			table.insert(el, Player)
			if table.valid(el) then
				for i,e in pairs(el) do
					if (e.role == 2 or e.role == 3) then
						DPSsize = DPSsize + 1
						if e.distance <= (20 + e.hitradius) then
							DPSNear = DPSNear + 1
						end
					end
				end
			end
			if DPSNear >= (DPSsize - 1) then
				GetAction(118):Cast()
			end
		end
	end

	local function UsePitchPerfect()
		 if PitchPerfect and CurrentSong == 3 and Repertoire >= 2 then
			GetAction(7404):Cast(currentTarget.id)
		elseif PitchPerfect and CurrentSong == 3 and Repertoire >= 1 and SongDuration <=3 then
			GetAction(7404):Cast(currentTarget.id)
		end
	end

	local function UseEmpyrealArrow()
		if EmpyrealArrow and GetAction(3558):IsReady(Player:GetTarget().id) and (GetAction(107).cd <= (GetAction(107).cdmax - GetAction(3558).recasttime)) then
			GetAction(3558):Cast(currentTarget.id)
		end
	end

	local function UseWardensPaean() -- TODO: Try to find a way to utilize this.
		if WardensPaean  then
			local el = EntityList("myparty,alive,maxdistance=31.5")
			table.insert(el, Player)
			if table.valid(el) then
				for i,e in pairs(el) do
					if i~=nil and e~=nil then
						if e.incombat then
							for a,b in pairs(e.buffs) do
								-- if b.name == "Berserk" and b.duration <= 5 then
								-- 	GetAction(3561):Cast(e.id)
								-- end
							end
						end
					end
				end
			end
		end
	end

	local function UseSidewinder() -- TODO: Provide the ability to use this on entities other than just your current target. Entities with your DoTs.
		if Sidewinder and GetAction(3562):IsReady(Player:GetTarget().id) and HasBuffs(Player:GetTarget(),"124+129,1200+1201") then
			GetAction(3562):Cast(currentTarget.id)
		end
	end

	local function UseTroubadour()
		if Troubadour and CurrentSong ~= 0 and GetAction(7405):IsReady() then
			local PTsize = 0
			local PTNear = 0
			local el = EntityList("myparty,incombat,alive,maxdistance=50")
			table.insert(el, Player)
			if table.valid(el) then
				for i,e in pairs(el) do
					PTsize = PTsize + 1
					if e.distance <= (20 + e.hitradius) then
						PTNear = PTNear + 1
					end
				end
			end
			if PTNear >= (PTsize - 1) then
				GetAction(7405):Cast()
			end
		end
	end

	local function UseNaturesMinne()
		if NaturesMinne and GetAction(7408):IsReady() then
			local el = EntityList("myparty,incombat,alive,maxdistance=31")
			table.insert(el, Player)
			if table.valid(el) then
				for i,e in pairs(el) do
					if (e.role == 1 or e.role == 4 or e.id == Player.id) and e.hp.percent < 50 then
						GetAction(7408):Cast(e.id)
					end
				end
			end
		end
	end

	local function UseSecondWind()
		if SecondWind and GetAction(7541):IsReady() and Player.hp.percent <= 70 and Player.incombat then
			GetAction(7541):Cast()
		end
	end

	local function UseFootGraze()
		-- TODO
	end

	local function UseLegGraze()
		-- TODO
	end

	local function UsePeloton()
		 if Peloton and not Player.ismounted and not Player.incombat and Player:IsMoving() and (TimeSince(profile.MoveStart) > (profile.PelotonDelay*1000)) and GetAction(7557):IsReady() and TimeSince(profile.OOCTime) >= 3000 then
	    	d("test1")
	    	local el = EntityList("myparty,alive,maxdistance=21.5")
	    	table.insert(el, Player)
			if table.valid(el) then
				d("test2")
				for i,e in pairs(el) do
					if i~=nil and e~=nil then
						if not e.incombat then
							d("test3")
							if MissingBuffs(e,"1199") then
								d("test4")
								GetAction(7557):Cast()
							end
						end
					end
				end
			end
	    end
	    if Player:IsMoving() and not Player.ismounted and (TimeSince(profile.MoveStart) > (profile.SprintDelay*1000)) and not GetAction(3).isoncd and MissingBuffs(Player,"3") then
	    	GetAction(3):Cast()
	    end
	end

	local function UseInvigorate()
		if Invigorate and not GetAction(7544).isoncd and Player.tp <= 500 and Player.incombat then
			GetAction(7544):Cast()
		end
	end

	local function UseTactician()
		if Tactician and GetAction(7555):IsReady() then
			local DPSsize = 0
			local DPSNear = 0
			local el = EntityList("myparty,incombat,alive,maxdistance=50")
			table.insert(el, Player)
			if table.valid(el) then
				for i,e in pairs(el) do
					if e.role~=4 then
						DPSsize = DPSsize + 1
						if e.distance <= (20 + e.hitradius) then
							DPSNear = DPSNear + 1
						end
					end
				end
				for i,e in pairs(el) do
					if e.tp < 500 and DPSNear >= (DPSsize - 1) then
						GetAction(7555):Cast()
					end
				end
			end
		end
	end

	local function UseRefresh()
		if Refresh and GetAction(7556):IsReady() then
			local DPSsize = 0
			local DPSNear = 0
			local el = EntityList("myparty,incombat,alive,maxdistance=50")
			if table.valid(el) then
				for i,e in pairs(el) do
					if e.role==4 then
						DPSsize = DPSsize + 1
						if e.distance <= (20 + e.hitradius) then
							DPSNear = DPSNear + 1
						end
					end
				end
				for i,e in pairs(el) do
					if e.mp.percent < 50 and DPSNear >= (DPSsize - 1) then
						GetAction(7556):Cast()
					end
				end
			end
		end
	end

	local function UseHeadGraze()
		-- TODO
	end

	local function UseArmGraze()
		-- TODO
	end

	local function UsePalisade()
		if Palisade and GetAction(7550):IsReady() then
			local el = EntityList("myparty,incombat,alive,maxdistance=50")
			if table.valid(el) then
				for i,e in pairs(el) do
					if e.role==1 or e.role==4 and e.hp.percent < 50 then
						GetAction(7550):Cast(e.id)
					end
				end
			end
		end
	end

	local function UseDexPotion()
		-- TODO
	end

	local function UseHpPotion()
		-- TODO
	end

	local TableToFunction = {
		["Heavy Shot"] = UseHeavyShot,
		["Straight Shot"] = UseStraightShot,
		["DoTs"] = UseDoTs,
		["Quick Nock"] = UseQuickNock,
		["Foe Requiem"] = UseFoeRequiem,
		["Refulgent Arrow"] = UseRefulgentArrow,
		["Raging Strikes"] = UseRagingStrikes,
		["Misery's End"] = UseMiserysEnd,
		["Bloodletter/Rain of Death"] = UseRainOfDeath,
		["Repelling Shot"] = UseRepellingShot,
		["Barrage"] = UseBarrage,
		["Songs"] = UseSongs,
		["Battle Voice"] = UseBattleVoice,
		["Pitch Perfect"] = UsePitchPerfect,
		["Empyreal Arrow"] = UseEmpyrealArrow,
		["The Wardens Paean"] = UseWardensPaean,
		["Sidewinder"] = UseSidewinder,
		["Troubadour"] = UseTroubadour,
		["Nature's Minne"] = UseNaturesMinne,
		["Second Wind"] = UseSecondWind,
		["Foot Graze"] = UseFootGraze,
		["Leg Graze"] = UseLegGraze,
		["Peloton (OOC)"] = UsePeloton,
		["Invigorate"] = UseInvigorate,
		["Tactician"] = UseTactician,
		["Refresh"] = UseRefresh,
		["Head Graze"] = UseHeadGraze,
		["Arm Graze"] = UseArmGraze,
		["Palisade"] = UsePalisade,
		["Potion (DEX)"] = UseDexPotion,
		["Potion (HP)"] = UseHpPotion
	}
    if currentTarget~=nil and EntityList:Get(currentTarget.id).type == 2 then
    	local GCDTable = profile.GCDPriorityTable
    	local oGCDTable = profile.oGCDPriorityTable
    	local FuncBL = profile.FunctionBL
	    if profile.oGCD then
	    	for k,v in ipairs(oGCDTable) do
	    		if FuncBL[v] then
					TableToFunction[v]()
				end
		    end
	    else
	    	for k,v in ipairs(GCDTable) do
	    		if FuncBL[v] then
					TableToFunction[v]()
				end
		    end
	    end
    end
    UsePeloton()
    UseFoeRequiem()
end

function profile.OnOpen()
	profile.GUI.open = true
end

return profile