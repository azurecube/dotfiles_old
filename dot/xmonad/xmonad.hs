import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W

import XMonad.Actions.WindowGo
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Util.EZConfig
import XMonad.Util.Paste


import System.IO
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import Control.Monad (liftM2)

import XMonad.Hooks.SetWMName

tall = ResizableTall 1 (3/100) (1/2) []
layout = smartBorders $ mkToggle1 FULL $ gaps [(U,24)] $ tall ||| Mirror tall
works = map show [1..9]
modm = mod4Mask


-- Window Location
myManageHookShift = composeAll
  [ className =? "Firefox" --> viewShift "1"
	, className =? "Emacs" --> viewShift "1"
	, className =? "URxvt" --> viewShift "1"
  , className =? "KeePass2" --> viewShift "4"
  , className =? "Google-chrome" --> viewShift "2"
  , className =? "com-sun-javaws-Main" --> viewShift "5"
  , className =? "VirtualBox" --> viewShift "6"
	]
	where viewShift = doF . liftM2 (.) W.view W.shift

-- Keybinds
windowOperation =
	[ ((modm, xK_z), sendMessage (Toggle FULL))
	, ((modm, xK_g), sendMessage ToggleGaps)
	, ((modm .|. shiftMask, xK_s), sendMessage MirrorShrink)
	, ((modm .|. shiftMask, xK_e), sendMessage MirrorExpand)
	, ((modm, xK_period), windows W.focusDown)
	, ((modm, xK_comma), windows W.focusUp)
	, ((modm .|. shiftMask, xK_period), windows W.swapDown)
	, ((modm .|. shiftMask, xK_comma), windows W.swapUp)
	, ((modm, xK_v), spawn "xdotool windowfocus; sleep 0.2; xdotool key --clearmodifiers shift+118; xdotool keyup 133")
	, ((controlMask, xK_colon), spawn "xdotool key Super_L+t;sleep 0.1;xdotool key ctrl+t ctrl+35")
	, ((modm, xK_b), spawn "xdotool key Super_L+t;sleep 0.1;xdotool key ctrl+t ctrl+35")
	, ((modm, xK_bracketright), spawn "xdotool key Super_L+t;sleep 0.1;xdotool key ctrl+t ctrl+51")
	, ((modm, xK_w), nextScreen) ]

screenOperation =
	[ ((modm .|. m, k), windows $ f i)
		| (i, k) <- zip works
								[ xK_exclam, xK_at, xK_numbersign
								, xK_dollar, xK_percent, xK_asciicircum
								, xK_ampersand, xK_asterisk, xK_parenleft
								, xK_parenright
								]
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
	]

applyOperation =
	[ --((modm, xK_e), runOrRaise "/usr/local/bin/emacs" (className =? "Emacs"))
	 ((modm, xK_t), runOrRaise "urxvt" (className =? "URxvt"))
	, ((modm, xK_f), runOrRaise "firefox" (className =? "Firefox"))
        , ((modm, xK_x), runOrRaise "/home/tomo/bin/toggle_xmobar.sh" (className =? "xmobar"))
        , ((modm, xK_e), runOrRaise "emacs" (className =? "Emacs"))
        , ((modm, xK_k), runOrRaise "keepass2" (className =? "KeePass2"))
        --, ((modm, xK_c), runOrRaise "hipchat4" (className =? "HipChat"))
        , ((modm, xK_c), runOrRaise "google-chrome" (className =? "google-chrome"))
      	]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig <+> myManageHookShift 
--XMobar
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "cyan" "" . shorten 50
                        }
        , terminal           = "urxvt"
        , borderWidth        = 2
        , normalBorderColor  = "#333333"
        , focusedBorderColor = "#6666ff"
				, modMask = mod4Mask
        -- For Java application
				, startupHook = setWMName "LG3D"
        }
        `additionalKeys` windowOperation
        `additionalKeys` screenOperation
        `additionalKeys` applyOperation
