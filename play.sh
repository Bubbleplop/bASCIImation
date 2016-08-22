#!/bin/bash

source Rocketship
#source Walfish
source set_values
source drawbox

play_animation () {

for ((current_frame=0; current_frame<=$[$frames-1]; current_frame++))
do
	if (( $(tput cols) != $terminal_width ))||(( $(tput lines) != $terminal_height ))
	then
		clear
		sleep 0.7
		set_values
		clear_expanded_lines
		drawbox_quick
	fi

	let "current_startframe=$current_frame*$movie_height+$crop_top"

	echo -en "\033["$[$expand_top]";1H"
	
	k=0

	for ((i=0; i<=$[$local_movie_height-1]; i++))
	do
		let "current_line=$current_startframe+$i"
		echo -en "\033[1C"
		output=${movie[$current_line]}

		if (($current_frame >= (($frames - 30)) ))&&(($i >= (($local_movie_height/2-2)) ))&& ! (($i >= (($local_movie_height/2+4)) ))
		then
			credits
			output="${movie[$current_line]:0:$[${#movie}/2-${#credit}/2-1]} ${credit[$k]} ${movie[$current_line]:$[${#movie}/2-${#credit}/2+${#credit}+${#movie}%2+${#credit}%2-1]:${#movie}}"
			let "k++"
		fi

		if (($terminal_width < $movie_width))
		then
			echo "$output" | cut -c$crop_left-$crop_right			
		elif (( (($terminal_width - $movie_width)) >= 2 ))
		then
			echo -en "\033["$[$expand_left]"C"
			echo "$output"
		else
			echo "$output" | cut -c3-$terminal_width
		fi
	done
	
	sleep 0.035
done
#clear
if (($give_information_please))
then
	infobox
fi
}

credits () {

j=0
while IFS= read -r; do
	credit[$j]=$REPLY
	let "j++"
#	tput cuf $[$thick_horizontal_middle-(${#line}/2+(${#line}%2))]; echo "$line" 
done < <(figlet -w $terminal_width "$credits_text"; echo)
}

clear_expanded_lines () {

if (($expand_top > 2))
then
	echo -en "\033[1;1H"
	for ((j=1; j<=$[$expand_top-3]; j++))
	do
		echo -en "\033[1B"
		tput el
	done
fi

echo -en "\033[1;1H"

if (($expand_bottom))
then
	echo -en "\033[$[$terminal_height-$expand_bottom];1H"
	for ((j=1; j<=$[$expand_bottom-1]; j++))
	do
		echo -en "\033[1B"
		tput el
	done
fi
}

# Some informations for debug

infobox () {

echo -en "\033[s"
echo -en "\033[2;1H"

echo -e "\033[1CTerminal has $terminal_height lines "
echo -e "\033[1CTerminal has $terminal_width columns "

echo -e "\033[1CAnimation has $frames frames "
echo -e "\033[1Cmovie_width: $movie_width, movie_height: $movie_height"
echo -e "\033[1Clocal_movie_heiht: $local_movie_height"
echo -e "\033[1Ccrop_top: $crop_top, crop_bottom: $crop_bottom"
echo -e "\033[1Cexpand_top $expand_top and expand_bottom $expand_bottom "
echo -e "\033[1Ccrop_left $crop_left and crop_right $crop_right"
echo -e "\033[1Cexpand_left $expand_left and expand_right $expand_right"
echo -e "\033[1Ccase_x is: $case_x and case_y is: $case_y "
echo -e "\033[1Ccase_tv is: $case_tv, case_th is: $case_th and case_tm is: $case_tm "
echo -e "\033[1CComandline Argument is: $OPTARG"
echo -e "\033[1CCredit Text is: $credits_text"
#echo -e "\033[1Cthin_vertical_middle: $thin_vertical_middle, thin_horizontal_middle: $thin_horizontal_middle"
}

test_drawbox () { # just a small debug function, can be deletet later.
clear
set_values
clear_expanded_lines
drawbox_quick

while :; do
	if (($terminal_height != $(tput lines) ))||(($terminal_width != $(tput cols) ))
	then
		clear
		sleep 0.5
		set_values
		clear_expanded_lines
		drawbox_quick
	fi
	sleep 0.01
done
}

while getopts "c:i" Option # I would love to put this in a function, but for some reason this isn't working.
do
	case $Option in
		c) credits_text=$OPTARG;;
		i) give_information_please=1;;
		*) credits_text="This is an Example Credit";;
	esac
done
shift $(($OPTIND - 1))

#test_drawbox
set_values # initializing Variables, this will also called when resizing the window while playing, to reset them all.
tput smcup # setting Terminal to alternate screen mode
setterm -cursor off # disable cursor blinking
clear_expanded_lines # Clear the blank lines between boarders
drawbox 0.0031 0.0041 # calling drawbox, the parameters are for the delay, in horizontal and vertikal drawing.
play_animation # Play the movie
setterm -cursor on # enable cursor blinking
tput rmcup # returning from alternate screen

exit 0
