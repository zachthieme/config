import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab
import XMonad.Util.NamedScratchpad

-- import XMonad.Actions.GroupNavigation

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing 
import XMonad.Layout.PerScreen
import XMonad.Layout.LayoutBuilder
import XMonad.Layout.Tabbed

import XMonad.Hooks.EwmhDesktops

main :: IO ()
main = xmonad
     . ewmh
     $ myConfig

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , terminal   = "kitty"
    , focusFollowsMouse = False 
    , layoutHook = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $ myLayout
    , manageHook = myManageHook
    }
  `additionalKeysP`
    [ ("M-]"  , spawn "chromium-browser"                   )
    , ("M-d"  , spawn "rofi -show drun  modi drun"                   )
    , ("M-/"  , spawn "/home/zach/.config/nixpkgs/xmonad/xmonad_keys.sh"                   )
--    , ((modMask .|. shiftMask, xK_h ), sendMessage $ IncLayoutN (-1))
--    , ((modMask .|. shiftMask, xK_l ), sendMessage $ IncLayoutN 1)
    ]

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Yad" --> doFloat
--    , isDialog            --> doFloat
    ]

--   < dimensions:    1366x980 pixels (361x259 millimeters)
myLayout = ifWider 1366 (threeCol ||| tiled ||| Full) Full 
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/3    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
