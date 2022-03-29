Installation instructions:

## Mac installations
cd ~/.config/kmonad
git clone --recursive https://github.com/kmonad/kmonad.git
stack build --flag kmonad:dext --extra-include-dirs=c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include

## link binary (make sure to use the whole path for the binary)
ln -s <massive path from above>/kmonad /usr/bin/local/kmonad

## install keyboard driver (dext)
cd ~/.config/kmoand/kmonad/
open c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/dist/Karabiner-DriverKit-VirtualHIDDevice-1.15.0.pkg

## activate the driver
/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate

## authorize the binary in the System Prefrences
drag and drop kmonad to  "Security and Privacy/Privacy/Input Monitoring"

## Make it autostart
copy plist to /library/launchdaemons
 
