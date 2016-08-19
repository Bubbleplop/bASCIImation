# bASCIImation

Hi there, 

this repository represents my earliest attempt in scripting with bash, and programming at all.
So if there're a few things over the top, it's because I wanted to try something new. (like using github)

I intendet it as a terminal intro, when you ssh into a server, for example.

### What it does:

The script plays prepared ASCII-videos, mostly blender-animations, in a terminal, running bash. It also draws a box around the video, which is resizing automaticly when the terminal changes its propotions.
Also it uses the programm Figlet to play a message in the last few frames, which you can define via option-switch parsing.

it was a lot of fun to build, and there is probably coming more.

### What it does not:

I'm eager to implement something that plays the video and than restores the terminal as it was, like "less" does, or "vim", if this is even posible in a scipt.
then, it should run the video directly from a viedeo-container like avi,.. 

at some point I will rebuild this in c++, and whatever I'll be on to after that.

### How to use:

change to bASCIImation directory and run 
```
./intro.sh -c "Hi $USER"
```
alternatively you can add the `-i` flag to show some debug info


heres a preview:
[![asciicast](https://asciinema.org/a/1xiz4pr48wvcl8vhlmibiypcw.png)](https://asciinema.org/a/1xiz4pr48wvcl8vhlmibiypcw)
