import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Spacing
import XMonad.Layout.DragPane
import XMonad.Layout.ThreeColumns
import XMonad.Layout.OneBig
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
myLayoutHook = (avoidStruts $ smartSpacing 3 $ (ThreeColMid 1 (3/100) (1/2) ||| OneBig (3/4) (3/4) ||| Grid)) ||| Full
myManageHookFloat = composeAll
    [(className =? "mikutter.rb" <&&> windowName =? "mikutter_image_preview") --> doFloat
    --[ className =? "Mikutter.rb" --> doFloat
    ]
    where
        windowName = stringProperty "WM_NAME"
        notInMonad r = return $ not r
myManageHook = myManageHookFloat <+> manageDocks
myLogHook h = dynamicLogWithPP myPP { ppOutput = hPutStrLn h }

myAdditionalKeysP :: [([Char], X ())]
myAdditionalKeysP =
    [ ("<XF86AudioMute>", spawn "if [ -n \"$(amixer sget Master | grep '\\[off\\]')\" ]; then amixer sset Master unmute; amixer sset PCM unmute; amixer sset Headphone unmute; amixer sset Speaker unmute; else amixer sset Master mute; amixer sset PCM mute; amixer sset Headphone mute; amixer sset Speaker mute; fi")
    , ("<XF86AudioMicMute>", spawn "amixer sset Mic toggle")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 9%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 9%-")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 5")

    , ("M1-<F1>", spawn "sudo chvt 1")
    , ("M1-<F2>", spawn "sudo chvt 2")
    , ("M1-<F3>", spawn "sudo chvt 3")
    , ("M1-<F4>", spawn "sudo chvt 4")
    , ("M1-<F5>", spawn "sudo chvt 5")
    , ("M1-<F6>", spawn "sudo chvt 6")
    , ("M1-<F7>", spawn "sudo chvt 7")
    , ("<XF86LaunchA>", spawn "$HOME/dotfiles/proxy_toggle.sh on && notify-send 'Enable Proxy' ''")
    , ("<XF86Explorer>", spawn "$HOME/dotfiles/proxy_toggle.sh off &&  notify-send 'Dissable Proxy' ''")

    , ("M-r", spawn "exe=`dmenu_run -fn 'xft:Ricty Discord for Powerline:style=RegularForPowerline:size=9:antialias=true'` && exec $exe")
    , ("M-u", spawn "thunderbird-daily")
    , ("M-i", spawn "firefox-nightly")
    , ("M-o", spawn "opera")
    , ("M-p", spawn "mikutter")
    , ("M-f", spawn "krusader")

    , ("M-<Return>", spawn myTerminal)
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
    , manageHook = myManageHook
    , logHook = myLogHook statusBar

    -- Appearance
    , borderWidth = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    }
    `additionalKeysP` myAdditionalKeysP
-- }}}
 

