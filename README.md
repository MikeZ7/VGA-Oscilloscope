# VGA Oscilloscope

Project of digital oscillscope built with an ADC on a Mimas Spartan 6 development board.

## Contents

Directory src:

- bram block
- vga driver
- pmod ad1 driver

GPIOs configuration file:

- pinout.ucf

## Results

[!Project demo](https://github.com/MikeZ7/VGA-Oscilloscope/assets/101725721/255fd25f-8f9c-401b-8667-34f5c615fb0e)

- DC signal
![](https://github.com/MikeZ7/VGA-Oscilloscope/blob/master/Images%26Video/dc_signal.jpg)

- Sine signal

![](https://github.com/MikeZ7/VGA-Oscilloscope/blob/master/Images%26Video/sine_signal.jpg)

- Triangle signal
 
![](https://github.com/MikeZ7/VGA-Oscilloscope/blob/master/Images%26Video/triangle_signal.jpg)

- Square signal

![](https://github.com/MikeZ7/VGA-Oscilloscope/blob/master/Images%26Video/square_signal.jpg)

# Flaws

Project displays oscillogram vertically due to simpler implementation. 
Oscilloscope lacks synchronization for reading from memory and displaying via VGA.
8 MSB bits from 12 bit data are used to avoid LUT memory usage so the waveforms are truncated.

--
# Future updates
- synchronization
- horizontal drawing
- auxiliary grid applied
- cursors
- second channel
- adjustment of the amplitude axis and time base
- trigger options
- math functions



