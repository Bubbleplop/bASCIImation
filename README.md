# bASCIImation

Hi there, 

this repository represents my earliest attempt in scripting with bash.
So if there're a few things over the top, it's because I wanted to try something new. (like using github)

I intendet it as a terminal intro, when you ssh into a server, for example.

### What it does:

The script plays prepared ASCII-videos, mostly blender-animations, in a terminal, running bash. 
It also draws a box around the video, which is resizing automaticly when the terminal changes its propotions. 
Also it uses the programm Figlet to play a message in the last few frames, which you can define via option-switch parsing.

it was a lot of fun to build, and will be by expanding it.

### What it does not:

~~I'm eager to implement something that plays the video and than restores the terminal as it was, like "less" does, or "vim", if this is even posible in a scipt.~~
As it turns out, this was quite simple. As statet at [Stack Overflow](http://stackoverflow.com/questions/39065430/bash-reset-terminal-output-as-it-was-before) .. love this site.

Next thing would be a fallback for figlet, so it doesn't need to be installed. 

The movies are optimised for fullscreen, thats because i run guake, which is streched horizontaly by default. I might change that too, or give an optione align the view.

### How to use:

change to bASCIImation directory and run 
```
./play.sh -c "Hi $USER"
```
alternatively you can add the `-i` flag to show some debug info
