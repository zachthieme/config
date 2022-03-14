
import XMonad

main :: IO ()
main = xmonad def
    { terminal    = "lxterminal"
    , borderWidth = 3
    }
