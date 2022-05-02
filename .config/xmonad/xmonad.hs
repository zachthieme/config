import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing 

import XMonad.Hooks.EwmhDesktops

main :: IO ()
main = xmonad
     $ myConfig

myConfig = def
    { modMask    = mod4Mask      -- Rebind Mod to the Super key
    , terminal   = "kitty"
    , focusFollowsMouse = False 
    , layoutHook = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $ myLayout
    }
  `additionalKeysP`
    [ ("M-]"  , spawn "chromium-browser"                   )
    , ("M-d"  , spawn "rofi -show run"                   )
    ]
-- TODO: add customization for when in ipad screen 
--   < dimensions:    1366x980 pixels (361x259 millimeters)
myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes
