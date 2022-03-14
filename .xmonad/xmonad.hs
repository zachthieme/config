import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Hooks.DynamicLog

main :: IO ()
main = xmonad . ewmh =<< xmobar myConfig