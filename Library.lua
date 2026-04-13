-- Oversimplified by Ege

local Oversimplified={Theme={Bg=Color3.fromRGB(24,24,27),Border=Color3.fromRGB(55,55,60),Text=Color3.fromRGB(228,228,231),Active=Color3.fromRGB(99,102,241),Inactive=Color3.fromRGB(40,40,45),SliderBg=Color3.fromRGB(45,45,50),DarkerBg=Color3.fromRGB(18,18,20)}}
local TS,UIS=game:GetService("TweenService"),game:GetService("UserInputService")
local CG=pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
local function MakeDraggable(f) local d,di,ds,sp f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true ds=i.Position sp=f.Position i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then d=false end end) end end) f.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then di=i end end) UIS.InputChanged:Connect(function(i) if i==di and d then local dl=i.Position-ds f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dl.X,sp.Y.Scale,sp.Y.Offset+dl.Y) end end) end
local function FadeUI(e,s,d) local t=TweenInfo.new(d,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out) local function tw(o) if not o:GetAttribute("OS") then o:SetAttribute("OS",true) if o:IsA("GuiObject") then o:SetAttribute("OBg",o.BackgroundTransparency) end if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then o:SetAttribute("OTx",o.TextTransparency) end if o:IsA("UIStroke") then o:SetAttribute("OSt",o.Transparency) end if o:IsA("ScrollingFrame") then o:SetAttribute("OSc",o.ScrollBarImageTransparency) end end local p={} if o:GetAttribute("OBg") then p.BackgroundTransparency=s and o:GetAttribute("OBg") or 1 end if o:GetAttribute("OTx") then p.TextTransparency=s and o:GetAttribute("OTx") or 1 end if o:GetAttribute("OSt") then p.Transparency=s and o:GetAttribute("OSt") or 1 end if o:GetAttribute("OSc") then p.ScrollBarImageTransparency=s and o:GetAttribute("OSc") or 1 end if next(p) then if d==0 then for k,v in pairs(p) do o[k]=v end else TS:Create(o,t,p):Play() end end end tw(e) for _,c in ipairs(e:GetDescendants()) do tw(c) end end
function Oversimplified:CreateWindow(tTxt,tClr,keyStr)
    if CG:FindFirstChild("OS_UI") then CG.OS_UI:Destroy() end
    local SG=Instance.new("ScreenGui",CG) SG.Name="OS_UI" SG.ResetOnSpawn=false SG.Enabled=false
    
    local MF=Instance.new("Frame",SG) MF.Size=UDim2.new(0,520,0,380) MF.Position=UDim2.new(0.5,-260,0.5,-190) MF.BackgroundColor3=self.Theme.Bg MF.Visible=false
    Instance.new("UICorner",MF).CornerRadius=UDim.new(0,6) Instance.new("UIStroke",MF).Color=self.Theme.Border MF.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border MakeDraggable(MF)
    
    local Ti=Instance.new("TextLabel",MF) Ti.Size=UDim2.new(1,0,0,30) Ti.BackgroundTransparency=1 Ti.Text="  "..tTxt Ti.TextColor3=tClr or self.Theme.Active Ti.Font=Enum.Font.GothamBold Ti.TextSize=14 Ti.TextXAlignment=Enum.TextXAlignment.Left
    local D=Instance.new("Frame",MF) D.Size=UDim2.new(1,0,0,1) D.Position=UDim2.new(0,0,0,30) D.BackgroundColor3=self.Theme.Border D.BorderSizePixel=0
    local VD=Instance.new("Frame",MF) VD.Size=UDim2.new(0,1,1,-30) VD.Position=UDim2.new(0,130,0,30) VD.BackgroundColor3=self.Theme.Border VD.BorderSizePixel=0
    
    local TC=Instance.new("ScrollingFrame",MF) TC.Size=UDim2.new(0,130,1,-75) TC.Position=UDim2.new(0,0,0,35) TC.BackgroundTransparency=1 TC.ScrollBarThickness=0
    local TL=Instance.new("UIListLayout",TC) TL.Padding=UDim.new(0,5) TL.HorizontalAlignment=Enum.HorizontalAlignment.Center TL.SortOrder=Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding",TC).PaddingTop=UDim.new(0,2) TC.UIPadding.PaddingBottom=UDim.new(0,2)
    
    local ProfFrame=Instance.new("Frame",MF) ProfFrame.Size=UDim2.new(0,130,0,40) ProfFrame.Position=UDim2.new(0,0,1,-40) ProfFrame.BackgroundTransparency=1
    local PDiv=Instance.new("Frame",ProfFrame) PDiv.Size=UDim2.new(1,0,0,1) PDiv.Position=UDim2.new(0,0,0,0) PDiv.BackgroundColor3=self.Theme.Border PDiv.BorderSizePixel=0
    local Avatar=Instance.new("ImageLabel",ProfFrame) Avatar.Size=UDim2.new(0,24,0,24) Avatar.Position=UDim2.new(0,8,0.5,-12) Avatar.BackgroundColor3=self.Theme.DarkerBg Avatar.Image="rbxthumb://type=AvatarHeadShot&id="..game.Players.LocalPlayer.UserId.."&w=150&h=150" Instance.new("UICorner",Avatar).CornerRadius=UDim.new(1,0) Instance.new("UIStroke",Avatar).Color=self.Theme.Border
    local NameLbl=Instance.new("TextLabel",ProfFrame) NameLbl.Size=UDim2.new(1,-44,1,0) NameLbl.Position=UDim2.new(0,38,0,0) NameLbl.BackgroundTransparency=1 NameLbl.Text=game.Players.LocalPlayer.DisplayName NameLbl.TextColor3=self.Theme.Text NameLbl.Font=Enum.Font.GothamMedium NameLbl.TextSize=11 NameLbl.TextXAlignment=Enum.TextXAlignment.Left NameLbl.TextTruncate=Enum.TextTruncate.AtEnd
    
    local CC=Instance.new("Frame",MF) CC.Size=UDim2.new(1,-135,1,-40) CC.Position=UDim2.new(0,130,0,35) CC.BackgroundTransparency=1
    local NC=Instance.new("Frame",SG) NC.Size=UDim2.new(0,250,1,-40) NC.Position=UDim2.new(1,-270,0,20) NC.BackgroundTransparency=1
    local NL=Instance.new("UIListLayout",NC) NL.Padding=UDim.new(0,10) NL.HorizontalAlignment=Enum.HorizontalAlignment.Center NL.VerticalAlignment=Enum.VerticalAlignment.Bottom
    
    local KF=nil
    if keyStr then
        KF=Instance.new("Frame",SG) KF.Size=UDim2.new(0,350,0,150) KF.Position=UDim2.new(0.5,-175,0.5,-75) KF.BackgroundColor3=self.Theme.Bg KF.Visible=false Instance.new("UICorner",KF).CornerRadius=UDim.new(0,6) Instance.new("UIStroke",KF).Color=self.Theme.Border MakeDraggable(KF)
        local KTitle=Instance.new("TextLabel",KF) KTitle.Size=UDim2.new(1,0,0,30) KTitle.BackgroundTransparency=1 KTitle.Text="  "..tTxt.." - Key System" KTitle.TextColor3=tClr or self.Theme.Active KTitle.Font=Enum.Font.GothamBold KTitle.TextSize=14 KTitle.TextXAlignment=Enum.TextXAlignment.Left
        local KD=Instance.new("Frame",KF) KD.Size=UDim2.new(1,0,0,1) KD.Position=UDim2.new(0,0,0,30) KD.BackgroundColor3=self.Theme.Border KD.BorderSizePixel=0
        local KInfo=Instance.new("TextLabel",KF) KInfo.Size=UDim2.new(1,-20,0,20) KInfo.Position=UDim2.new(0,10,0,45) KInfo.BackgroundTransparency=1 KInfo.Text="Please enter the access key to continue." KInfo.TextColor3=self.Theme.Text KInfo.Font=Enum.Font.Gotham KInfo.TextSize=12
        local KInput=Instance.new("TextBox",KF) KInput.Size=UDim2.new(1,-20,0,30) KInput.Position=UDim2.new(0,10,0,70) KInput.BackgroundColor3=self.Theme.DarkerBg KInput.TextColor3=self.Theme.Text KInput.PlaceholderText="Enter Key Here..." KInput.Font=Enum.Font.Gotham KInput.TextSize=12 KInput.ClearTextOnFocus=false Instance.new("UICorner",KInput).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",KInput).Color=self.Theme.Border
        local KBtn=Instance.new("TextButton",KF) KBtn.Size=UDim2.new(1,-20,0,30) KBtn.Position=UDim2.new(0,10,0,110) KBtn.BackgroundColor3=self.Theme.Inactive KBtn.TextColor3=self.Theme.Text KBtn.Text="Submit Key" KBtn.Font=Enum.Font.GothamMedium KBtn.TextSize=13 KBtn.AutoButtonColor=false Instance.new("UICorner",KBtn).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",KBtn).Color=self.Theme.Border
        KBtn.MouseButton1Click:Connect(function()
            if KInput.Text==keyStr then
                FadeUI(KF,false,0.2) task.wait(0.2) KF:Destroy() KF=nil
                FadeUI(MF,false,0) MF.Visible=true FadeUI(MF,true,0.4)
            else
                KInput.Text="" KInput.PlaceholderText="Incorrect Key!" TS:Create(KInput,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(150,40,40)}):Play() task.delay(0.2,function() TS:Create(KInput,TweenInfo.new(0.2),{BackgroundColor3=self.Theme.DarkerBg}):Play() end) task.delay(1.5,function() KInput.PlaceholderText="Enter Key Here..." end)
            end
        end)
    end
    
    task.delay(0.15,function()
        SG.Enabled=true
        if KF then FadeUI(KF,false,0) KF.Visible=true FadeUI(KF,true,0.4)
        else FadeUI(MF,false,0) MF.Visible=true FadeUI(MF,true,0.4) end
    end)
    
    local iv,it=true,false
    UIS.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.Insert and not it then
            if KF and KF.Parent then return end
            it=true iv=not iv
            if iv then FadeUI(MF,false,0) MF.Visible=true FadeUI(MF,true,0.3) task.wait(0.3)
            else FadeUI(MF,false,0.3) task.wait(0.3) MF.Visible=false end
            it=false
        end
    end)
    
    local WO={CT=nil} local isS=false
    function WO:Notify(ti,de,dr) dr=dr or 3 local NW=Instance.new("Frame",NC) NW.Size=UDim2.new(1,0,0,60) NW.BackgroundTransparency=1 local NM=Instance.new("Frame",NW) NM.Size=UDim2.new(1,0,1,0) NM.Position=UDim2.new(1,270,0,0) NM.BackgroundColor3=Oversimplified.Theme.Bg Instance.new("UICorner",NM).CornerRadius=UDim.new(0,6) Instance.new("UIStroke",NM).Color=Oversimplified.Theme.Border NM.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border local NT=Instance.new("TextLabel",NM) NT.Size=UDim2.new(1,-20,0,20) NT.Position=UDim2.new(0,10,0,5) NT.BackgroundTransparency=1 NT.Text=ti NT.TextColor3=Oversimplified.Theme.Active NT.Font=Enum.Font.GothamBold NT.TextSize=13 NT.TextXAlignment=Enum.TextXAlignment.Left local ND=Instance.new("TextLabel",NM) ND.Size=UDim2.new(1,-20,0,25) ND.Position=UDim2.new(0,10,0,25) ND.BackgroundTransparency=1 ND.Text=de ND.TextColor3=Oversimplified.Theme.Text ND.Font=Enum.Font.Gotham ND.TextSize=12 ND.TextXAlignment=Enum.TextXAlignment.Left ND.TextWrapped=true TS:Create(NM,TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play() task.delay(dr,function() local t=TS:Create(NM,TweenInfo.new(0.4,Enum.EasingStyle.Cubic,Enum.EasingDirection.In),{Position=UDim2.new(1,270,0,0)}) t:Play() t.Completed:Wait() NW:Destroy() end) end
    function WO:CreateTab(tN)
        local TB=Instance.new("TextButton",TC) TB.Size=UDim2.new(1,-16,0,30) TB.BackgroundColor3=self.CT==tN and Oversimplified.Theme.Active or Oversimplified.Theme.Inactive TB.TextColor3=Oversimplified.Theme.Text TB.Font=Enum.Font.GothamMedium TB.TextSize=13 TB.Text=tN TB.AutoButtonColor=false Instance.new("UICorner",TB).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",TB).Color=Oversimplified.Theme.Border TB.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
        local TSc=Instance.new("ScrollingFrame",CC) TSc.Size=UDim2.new(1,0,1,0) TSc.BackgroundTransparency=1 TSc.ScrollBarThickness=2 TSc.Visible=false local L=Instance.new("UIListLayout",TSc) L.Padding=UDim.new(0,6) L.HorizontalAlignment=Enum.HorizontalAlignment.Center L.SortOrder=Enum.SortOrder.LayoutOrder Instance.new("UIPadding",TSc).PaddingTop=UDim.new(0,2) TSc.UIPadding.PaddingBottom=UDim.new(0,2)
        L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() TSc.CanvasSize=UDim2.new(0,0,0,L.AbsoluteContentSize.Y+15) end)
        TB.MouseButton1Click:Connect(function() if WO.CT==tN or isS then return end isS=true for _,b in ipairs(TC:GetChildren()) do if b:IsA("TextButton") then TS:Create(b,TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{BackgroundColor3=Oversimplified.Theme.Inactive}):Play() end end TS:Create(TB,TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out),{BackgroundColor3=Oversimplified.Theme.Active}):Play() local cS=nil for _,c in ipairs(CC:GetChildren()) do if c:IsA("ScrollingFrame") and c.Visible then cS=c break end end if cS then FadeUI(cS,false,0.15) task.wait(0.15) cS.Visible=false end TSc.Visible=true WO.CT=tN FadeUI(TSc,false,0) FadeUI(TSc,true,0.15) task.wait(0.15) isS=false end)
        if not self.CT then TSc.Visible=true TB.BackgroundColor3=Oversimplified.Theme.Active self.CT=tN end
        local E={} local eO=0
        function E:CreateParagraph(ti,de,tC,dC)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,50) C.BackgroundColor3=Oversimplified.Theme.Bg Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local LT=Instance.new("TextLabel",C) LT.Size=UDim2.new(1,-20,0,20) LT.Position=UDim2.new(0,10,0,5) LT.BackgroundTransparency=1 LT.Text=ti LT.TextColor3=tC or Oversimplified.Theme.Active LT.Font=Enum.Font.GothamBold LT.TextSize=13 LT.TextXAlignment=Enum.TextXAlignment.Left
            local LD=Instance.new("TextLabel",C) LD.Size=UDim2.new(1,-20,0,20) LD.Position=UDim2.new(0,10,0,25) LD.BackgroundTransparency=1 LD.Text=de LD.TextColor3=dC or Oversimplified.Theme.Text LD.Font=Enum.Font.Gotham LD.TextSize=12 LD.TextXAlignment=Enum.TextXAlignment.Left LD.TextWrapped=true
            local PO={} function PO:Set(t,d,c1,c2) if t then LT.Text=t end if d then LD.Text=d end if c1 then LT.TextColor3=c1 end if c2 then LD.TextColor3=c2 end end return PO
        end
        function E:CreateLabel(tx,tC)
            local Lb=Instance.new("TextLabel",TSc) eO=eO+1 Lb.LayoutOrder=eO Lb.Size=UDim2.new(1,-14,0,25) Lb.BackgroundTransparency=1 Lb.TextColor3=tC or Oversimplified.Theme.Active Lb.Font=Enum.Font.GothamBold Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left Lb.Text=tx
            local LO={} function LO:Set(t,c) if t then Lb.Text=t end if c then Lb.TextColor3=c end end return LO
        end
        function E:CreateButton(tx,cb)
            local B=Instance.new("TextButton",TSc) eO=eO+1 B.LayoutOrder=eO B.Size=UDim2.new(1,-14,0,34) B.BackgroundColor3=Oversimplified.Theme.Inactive B.TextColor3=Oversimplified.Theme.Text B.Font=Enum.Font.GothamMedium B.TextSize=13 B.Text=tx B.AutoButtonColor=false Instance.new("UICorner",B).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",B).Color=Oversimplified.Theme.Border B.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            B.MouseButton1Click:Connect(function() TS:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Oversimplified.Theme.Active}):Play() task.wait(0.1) TS:Create(B,TweenInfo.new(0.1),{BackgroundColor3=Oversimplified.Theme.Inactive}):Play() cb() end)
            local BO={} function BO:Set(t) B.Text=t end return BO
        end
        function E:CreateToggle(tx,df,cb)
            local C=Instance.new("TextButton",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,34) C.BackgroundColor3=Oversimplified.Theme.Bg C.Text="" C.AutoButtonColor=false Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local Lb=Instance.new("TextLabel",C) Lb.Size=UDim2.new(1,-60,1,0) Lb.Position=UDim2.new(0,10,0,0) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local Tr=Instance.new("Frame",C) Tr.Size=UDim2.new(0,36,0,18) Tr.Position=UDim2.new(1,-46,0.5,-9) Tr.BackgroundColor3=df and Oversimplified.Theme.Active or Oversimplified.Theme.Inactive Instance.new("UICorner",Tr).CornerRadius=UDim.new(1,0)
            local Ci=Instance.new("Frame",Tr) Ci.Size=UDim2.new(0,14,0,14) Ci.Position=df and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7) Ci.BackgroundColor3=Color3.fromRGB(255,255,255) Instance.new("UICorner",Ci).CornerRadius=UDim.new(1,0)
            local st=df local function upd(s) st=s cb(st) TS:Create(Tr,TweenInfo.new(0.2),{BackgroundColor3=st and Oversimplified.Theme.Active or Oversimplified.Theme.Inactive}):Play() TS:Create(Ci,TweenInfo.new(0.2),{Position=st and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)}):Play() end
            C.MouseButton1Click:Connect(function() upd(not st) end)
            local TO={} function TO:Set(s) upd(s) end return TO
        end
        function E:CreateSlider(tx,mn,mx,df,cb)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,50) C.BackgroundColor3=Oversimplified.Theme.Bg Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local Lb=Instance.new("TextLabel",C) Lb.Size=UDim2.new(1,-20,0,20) Lb.Position=UDim2.new(0,10,0,5) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local VL=Instance.new("TextLabel",C) VL.Size=UDim2.new(0,50,0,20) VL.Position=UDim2.new(1,-60,0,5) VL.BackgroundTransparency=1 VL.Text=tostring(df) VL.TextColor3=Oversimplified.Theme.Text VL.Font=Enum.Font.GothamMedium VL.TextSize=13 VL.TextXAlignment=Enum.TextXAlignment.Right
            local SB=Instance.new("TextButton",C) SB.Size=UDim2.new(1,-20,0,8) SB.Position=UDim2.new(0,10,0,30) SB.BackgroundColor3=Oversimplified.Theme.SliderBg SB.Text="" SB.AutoButtonColor=false Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)
            local SF=Instance.new("Frame",SB) SF.Size=UDim2.new(math.clamp((df-mn)/(mx-mn),0,1),0,1,0) SF.BackgroundColor3=Oversimplified.Theme.Active Instance.new("UICorner",SF).CornerRadius=UDim.new(1,0)
            local dg=false local function usv(v) v=math.clamp(v,mn,mx) local pc=(v-mn)/(mx-mn) TS:Create(SF,TweenInfo.new(0.05),{Size=UDim2.new(pc,0,1,0)}):Play() VL.Text=tostring(v) cb(v) end
            local function us(i) local pc=math.clamp((i.Position.X-SB.AbsolutePosition.X)/SB.AbsoluteSize.X,0,1) local v=math.floor(mn+(mx-mn)*pc) usv(v) end
            SB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true us(i) end end) UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=false end end) UIS.InputChanged:Connect(function(i) if dg and i.UserInputType==Enum.UserInputType.MouseMovement then us(i) end end)
            local SO={} function SO:Set(v) usv(v) end return SO
        end
        function E:CreateInput(tx,pl,cb)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,34) C.BackgroundColor3=Oversimplified.Theme.Bg Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local Lb=Instance.new("TextLabel",C) Lb.Size=UDim2.new(0.5,0,1,0) Lb.Position=UDim2.new(0,10,0,0) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local IB=Instance.new("TextBox",C) IB.Size=UDim2.new(0.5,-20,0,24) IB.Position=UDim2.new(0.5,10,0.5,-12) IB.BackgroundColor3=Oversimplified.Theme.DarkerBg IB.TextColor3=Oversimplified.Theme.Text IB.PlaceholderText=pl IB.Font=Enum.Font.Gotham IB.TextSize=12 IB.ClearTextOnFocus=false Instance.new("UICorner",IB).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",IB).Color=Oversimplified.Theme.Border IB.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            IB.FocusLost:Connect(function() cb(IB.Text) end)
            local IO={} function IO:Set(t) IB.Text=t end return IO
        end
        function E:CreateKeybind(tx,dk,cb)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,34) C.BackgroundColor3=Oversimplified.Theme.Bg Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local Lb=Instance.new("TextLabel",C) Lb.Size=UDim2.new(0.5,0,1,0) Lb.Position=UDim2.new(0,10,0,0) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local startText=dk and dk.Name or "None"
            local BB=Instance.new("TextButton",C) BB.Size=UDim2.new(0,80,0,24) BB.Position=UDim2.new(1,-90,0.5,-12) BB.BackgroundColor3=Oversimplified.Theme.DarkerBg BB.TextColor3=Oversimplified.Theme.Active BB.Font=Enum.Font.GothamBold BB.TextSize=12 BB.Text=startText BB.AutoButtonColor=false Instance.new("UICorner",BB).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",BB).Color=Oversimplified.Theme.Border BB.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local cK,ls=dk,false BB.MouseButton1Click:Connect(function() ls=true BB.Text="..." local cn cn=UIS.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Keyboard then ls=false if i.KeyCode==Enum.KeyCode.Backspace then cK=nil BB.Text="None" else cK=i.KeyCode BB.Text=cK.Name end cn:Disconnect() end end) end)
            UIS.InputBegan:Connect(function(i,g) if not ls and not g and cK and i.KeyCode==cK then cb(cK) end end)
            local KO={} function KO:Set(k) cK=k BB.Text=k and k.Name or "None" end return KO
        end
        function E:CreateDropdown(tx,op,df,cb)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,34) C.BackgroundColor3=Oversimplified.Theme.Bg C.ClipsDescendants=true Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local DB=Instance.new("TextButton",C) DB.Size=UDim2.new(1,0,0,34) DB.BackgroundTransparency=1 DB.Text="" DB.AutoButtonColor=false
            local Lb=Instance.new("TextLabel",DB) Lb.Size=UDim2.new(0.5,0,1,0) Lb.Position=UDim2.new(0,10,0,0) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local SL=Instance.new("TextLabel",DB) SL.Size=UDim2.new(0.5,-30,1,0) SL.Position=UDim2.new(0.5,0,0,0) SL.BackgroundTransparency=1 SL.Text=df SL.TextColor3=Oversimplified.Theme.Active SL.Font=Enum.Font.GothamMedium SL.TextSize=12 SL.TextXAlignment=Enum.TextXAlignment.Right
            local Ic=Instance.new("TextLabel",DB) Ic.Size=UDim2.new(0,20,1,0) Ic.Position=UDim2.new(1,-20,0,0) Ic.BackgroundTransparency=1 Ic.Text="+" Ic.TextColor3=Oversimplified.Theme.Text Ic.Font=Enum.Font.GothamBold Ic.TextSize=14
            local OC=Instance.new("Frame",C) OC.Size=UDim2.new(1,-20,0,0) OC.Position=UDim2.new(0,10,0,34) OC.BackgroundTransparency=1 Instance.new("UIListLayout",OC).Padding=UDim.new(0,2)
            local opn=false local function tg() opn=not opn Ic.Text=opn and "-" or "+" TS:Create(C,TweenInfo.new(0.2),{Size=opn and UDim2.new(1,-14,0,34+(#op*26)+5) or UDim2.new(1,-14,0,34)}):Play() end DB.MouseButton1Click:Connect(tg)
            local function bO(oA) for _,c in ipairs(OC:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end for _,o in ipairs(oA) do local OB=Instance.new("TextButton",OC) OB.Size=UDim2.new(1,0,0,24) OB.BackgroundColor3=Oversimplified.Theme.DarkerBg OB.TextColor3=Oversimplified.Theme.Text OB.Font=Enum.Font.Gotham OB.TextSize=12 OB.Text=o OB.AutoButtonColor=false Instance.new("UICorner",OB).CornerRadius=UDim.new(0,4) OB.MouseButton1Click:Connect(function() SL.Text=o tg() cb(o) end) end end bO(op)
            local DO={} function DO:Set(o) SL.Text=o cb(o) end function DO:Refresh(nO,nD) op=nO bO(op) if nD then DO:Set(nD) end if opn then TS:Create(C,TweenInfo.new(0.2),{Size=UDim2.new(1,-14,0,34+(#op*26)+5)}):Play() end end return DO
        end
        function E:CreateColorPicker(tx,dc,cb)
            local C=Instance.new("Frame",TSc) eO=eO+1 C.LayoutOrder=eO C.Size=UDim2.new(1,-14,0,34) C.BackgroundColor3=Oversimplified.Theme.Bg C.ClipsDescendants=true Instance.new("UICorner",C).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",C).Color=Oversimplified.Theme.Border C.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local PB=Instance.new("TextButton",C) PB.Size=UDim2.new(1,0,0,34) PB.BackgroundTransparency=1 PB.Text="" PB.AutoButtonColor=false
            local Lb=Instance.new("TextLabel",PB) Lb.Size=UDim2.new(0.5,0,1,0) Lb.Position=UDim2.new(0,10,0,0) Lb.BackgroundTransparency=1 Lb.Text=tx Lb.TextColor3=Oversimplified.Theme.Text Lb.Font=Enum.Font.GothamMedium Lb.TextSize=13 Lb.TextXAlignment=Enum.TextXAlignment.Left
            local CP=Instance.new("Frame",PB) CP.Size=UDim2.new(0,40,0,16) CP.Position=UDim2.new(1,-50,0.5,-8) CP.BackgroundColor3=dc Instance.new("UICorner",CP).CornerRadius=UDim.new(0,4) Instance.new("UIStroke",CP).Color=Oversimplified.Theme.Border CP.UIStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
            local SF=Instance.new("Frame",C) SF.Size=UDim2.new(1,-20,0,80) SF.Position=UDim2.new(0,10,0,34) SF.BackgroundTransparency=1 Instance.new("UIListLayout",SF).Padding=UDim.new(0,5)
            local opn=false PB.MouseButton1Click:Connect(function() opn=not opn TS:Create(C,TweenInfo.new(0.2),{Size=opn and UDim2.new(1,-14,0,120) or UDim2.new(1,-14,0,34)}):Play() end)
            local r,g,b=dc.R*255,dc.G*255,dc.B*255 local function uC() local nC=Color3.fromRGB(r,g,b) CP.BackgroundColor3=nC cb(nC) end
            local sUpds={} local function cCS(cN,dV,tC)
                local sF=Instance.new("Frame",SF) sF.Size=UDim2.new(1,0,0,20) sF.BackgroundTransparency=1 local sB=Instance.new("TextButton",sF) sB.Size=UDim2.new(1,-30,0,6) sB.Position=UDim2.new(0,0,0.5,-3) sB.BackgroundColor3=Oversimplified.Theme.SliderBg sB.Text="" sB.AutoButtonColor=false Instance.new("UICorner",sB).CornerRadius=UDim.new(1,0) local sFi=Instance.new("Frame",sB) sFi.Size=UDim2.new(dV/255,0,1,0) sFi.BackgroundColor3=tC Instance.new("UICorner",sFi).CornerRadius=UDim.new(1,0) local sV=Instance.new("TextLabel",sF) sV.Size=UDim2.new(0,25,1,0) sV.Position=UDim2.new(1,-25,0,0) sV.BackgroundTransparency=1 sV.Text=tostring(math.floor(dV)) sV.TextColor3=Oversimplified.Theme.Text sV.Font=Enum.Font.Gotham sV.TextSize=11
                sUpds[cN]=function(vl) local pc=vl/255 TS:Create(sFi,TweenInfo.new(0.05),{Size=UDim2.new(pc,0,1,0)}):Play() sV.Text=tostring(math.floor(vl)) if cN=="R" then r=vl elseif cN=="G" then g=vl else b=vl end end
                local dg=false local function sU(i) local pc=math.clamp((i.Position.X-sB.AbsolutePosition.X)/sB.AbsoluteSize.X,0,1) local vl=math.floor(pc*255) sUpds[cN](vl) uC() end
                sB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=true sU(i) end end) UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dg=false end end) UIS.InputChanged:Connect(function(i) if dg and i.UserInputType==Enum.UserInputType.MouseMovement then sU(i) end end)
            end cCS("R",r,Color3.fromRGB(255,75,75)) cCS("G",g,Color3.fromRGB(75,255,75)) cCS("B",b,Color3.fromRGB(75,75,255))
            local CPO={} function CPO:Set(c) sUpds["R"](c.R*255) sUpds["G"](c.G*255) sUpds["B"](c.B*255) uC() end return CPO
        end return E
    end return WO
end return Oversimplified
