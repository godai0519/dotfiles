import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.Grid
import XMonad.Util.Run
import XMonad.Util.EZConfig

myBorderWidth = 1
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myTerminal = "urxvt"
myModMask = mod4Mask
myWorkspaces = ["Work", "Browse", "Others", "SNS"]

myStartupHook = do
    spawn "$HOME/.xmonad/wallpaper.sh"
    setWMName "LG3D"
myLayout = (ResizableTall 1 (1/201) (116/201) [])
myLayoutHook = avoidStruts $ ( toggleLayouts (noBorders Full) $ smartSpacing 3 myLayout)
myManageHookFloat = composeAll
    [ windowName =? "mikutter_image_preview" --> doCenterFloat
    , isDialog                               --> doCenterFloat
    , isFullscreen                           --> doFullFloat
    ]
    where
        windowName = stringProperty "WM_NAME"
        notInMonad r = return $ not r
myManageHookShift = composeAll
    [ className =? "MATLAB" --> doShift "1"
    ]
myLogHook h = dynamicLogWithPP myPP { ppOutput = hPutStrLn h }

myAdditionalKeysP :: [([Char], X ())]
myAdditionalKeysP =
    [ ("<XF86AudioMute>", spawn "if [ -n \"$(amixer sget Master | grep '\\[off\\]')\" ]; then amixer sset Master unmute; amixer sset PCM unmute; amixer sset Headphone unmute; amixer sset Speaker unmute; else amixer sset Master mute; amixer sset PCM mute; amixer sset Headphone mute; amixer sset Speaker mute; fi")
    , ("<XF86AudioMicMute>", spawn "amixer sset Mic toggle")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 9%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 9%-")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 5")

    , ("M-<Backspace>", spawn "dm-tool lock")
    , ("M-=", spawn "xset dpms force off")
    , ("M1-<F1>", spawn "sudo chvt 1")
    , ("M1-<F2>", spawn "sudo chvt 2")
    , ("M1-<F3>", spawn "sudo chvt 3")
    , ("M1-<F4>", spawn "sudo chvt 4")
    , ("M1-<F5>", spawn "sudo chvt 5")
    , ("M1-<F6>", spawn "sudo chvt 6")
    , ("M1-<F7>", spawn "sudo chvt 7")

    , ("M-r", spawn "exe=`dmenu_run -fn 'xft:Ricty Discord for Powerline:style=RegularForPowerline:size=9:antialias=true'` && exec $exe")
    , ("M-m", spawn "thunderbird")
    , ("M-i", spawn "firefox")

    , ("M-<Return>", spawn myTerminal)
    , ("M-f", sendMessage ToggleLayout)
    ]

-- Setting of XMobar {{{  
myBar = "xmobar $HOME/.xmonad/xmobarrc"
myPP = xmobarPP { ppTitle  = xmobarColor "white" "" . shorten 80 }
-- }}}

-- Main Function {{{ 
main = xmonad . docks . myConfig =<< spawnPipe myBar
-- }}}

-- Configuration (No change, basically) {{{
myConfig statusBar = defaultConfig
    { terminal = myTerminal
    , modMask = myModMask
    , workspaces = myWorkspaces
    , focusFollowsMouse = False

    -- Hocks
    , startupHook = myStartupHook
    , layoutHook = myLayoutHook
    , manageHook = myManageHookShift <+>
                   myManageHookFloat <+>
                   manageDocks
    , logHook = myLogHook statusBar

    -- Appearance
    , borderWidth = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    }
    `additionalKeysP` myAdditionalKeysP
-- }}}
 

