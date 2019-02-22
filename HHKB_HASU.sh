# Reload keymap on HHKB Pro 2 with Hasu controller bluetooth

brew tap osx-cross/avr
# take long time to compile
brew install avr-libc
brew install dfu-programmer

# turn hhkb to bootloader mode (the keyboard will stop working)
# LShift + RShift + Fn + p

# prepare tmk keymap and download HEX `myspacefn.hex` file, or load your own keymap
# http://www.tmk-kbd.com/tmk_keyboard/editor/unimap/?hhkb

sudo dfu-programmer atmega32u4 erase
sudo dfu-programmer atmega32u4 flash myspacefn.hex
sudo dfu-programmer atmega32u4 reset
