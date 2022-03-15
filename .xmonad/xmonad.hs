import XMonad
import XMonad.Config.Desktop

main = xmonad desktopConfig
    { terminal    = "lxterminal"
                , modMask = mod4Mask
    , borderWidth = 5
    }
