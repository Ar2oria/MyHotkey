AltState = 0
CtrlState = 0
; ============main key=========
; LAlt 按键
LAlt::
	if CtrlState = 1		; LCtrl被按下，LAlt复原
	{
		AltState = 1
		SendInput {LAlt Down}
	}
	else if AltState = 0		; 第一个被按下，改键为LCtrl
	{
		AltState = 2
		SendInput {LCtrl Down}
	}
Return

LAlt up::
	if AltState = 1
	{
		SendInput {LAlt Up}
	}
	else if AltState = 2
	{
		SendInput {LCtrl Up}
	}
	else if AltState = 3
	{
		; 特殊情况不处理
	}
	AltState = 0
Return

; LCtrl按键
LCtrl::
	if AltState = 2		; LAlt已经被按下，改建为LAlt
	{
		CtrlState = 2
		SendInput {LAlt Down}
	}
	else			; 默认输出LCtrl
	{
		CtrlState = 1
		SendInput {LCtrl Down}
	}
Return

LCtrl up::
	if CtrlState = 1
	{
		SendInput {LCtrl up}
	}
	else if CtrlState = 2
	{
		SendInput {LAlt up}
	}
	CtrlState = 0
Return

Space::
	if CtrlState = 1
	{
		SendInput {LCtrl Up}
		CtrlState = 0
	}
	if AltState = 2
	{
		SendInput {LCtrl Up}
		SendInput {LAlt Down}
		AltState = 1
	}
	SendInput {Space Down}
Return

Space up::
	SendInput {Space Up}
Return
; ==========Spc key========
; 左Win换成左 LAlt
LWin:: LAlt

; 替换菜单键为Win
AppsKey:: LWin

; 输入法/大小写切换
CapsLock::
	KeyWait, CapsLock, T0.3
	If ErrorLevel
	{
   		SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"
    		KeyWait, CapsLock
	}
	else
	{
		SetCapsLockState, % "Off"
		SendInput {LCtrl down}{Space}{LCtrl up}
	}
Return

; 屏蔽输入法切换
LShift::
	if AltState
	{
		Return
	}
	else
	{
		SendInput {LShift Down}
	}
Return

LShift up::
	if AltState
	{
		Return
	}
	else
	{
		SendInput {LShift Up}
	}
Return


;  tab  翻页功能不变
tab::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {LAlt Down}{tab}
		AltState = 1
	}
	else
	{
		SendInput {tab Down}
	}
Return

tab up::
	SendInput {tab Up}
Return

; 左Alt + [ = 后退
[::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {LAlt Down}{Left Down}
		AltState = 1
	}
	else
	{
		SendInput {[ Down}
	}
Return

[ up::
	if AltState
	{
		SendInput {Left Up}
	}
	else
	{
		SendInput {[ Up}
	}
Return

; 左Alt + ] = 前进
]::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {LAlt Down}{Right Down}
		AltState = 1
	}
	else
	{
		SendInput {] Down}
	}
Return

] up::
	if AltState
	{
		SendInput {Right Up}
	}
	else
	{
		SendInput {] Up}
	}
Return

; 左Alt + 方向上键 = 上一页
Up::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {PgUp Down}
		AltState = 3
	}
	else
	{
		SendInput {Up Down}
	}
Return

Up up::
	if AltState
	{
		SendInput {PgUp Up}
	}
	else
	{
		SendInput {Up Up}
	}
Return

; 左Alt + 方向下键 = 下一页
Down::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {PgDn Down}
		AltState = 3
	}
	else
	{
		SendInput {Down Down}
	}
Return

Down up::
	if AltState
	{
		SendInput {PgDn Up}
	}
	else
	{
		SendInput {Down Up}
	}
Return

; 左Alt + 方向左键 = Home（光标移到行首）
Left::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {Home Down}
		AltState = 3
	}
	else
	{
		SendInput {Left Down}
	}
Return

Left up::
	if AltState
	{
		SendInput {Home Up}
	}
	else
	{
		SendInput {Left Up}
	}
Return

; 左Alt + 方向右键 = End（光标移到行尾）
Right::
	if AltState
	{
		if AltState = 2
		{
			SendInput {LCtrl Up}
		}
		SendInput {End Down}
		AltState = 3
	}
	else
	{
		SendInput {Right Down}
	}
Return

Right up::
	if AltState
	{
		SendInput {End Up}
	}
	else
	{
		SendInput {Right Up}
	}
Return


#IF AltState = 2
	; 按住左Alt + 左shift + 方向左 = 向左选中到行首
	LShift & Left::
		SendInput {LCtrl Up}
		SendInput {LShift Down}{Home}{LShift Up}
		SendInput {LCtrl Down}
	Return

	; 按住左Alt + 左shift + 方向右 = 向右选中到行尾
	LShift & Right::
		SendInput {LCtrl Up}
		SendInput {LShift Down}{End}{LShift Up}
		SendInput {LCtrl Down}
	Return

