#!/bin/bash

drawbox () {

# Draw top and bottom 

for ((i=$thick_horizontal_middle; i>=1; i--))
do
	if (($thick_horizontal_middle))
	then
		echo -en "\033[1;"$thick_horizontal_middle"H"; echo -n "═"
		echo -en "\033["$terminal_height";"$thick_horizontal_middle"H"; echo -n "═"
	fi

	echo -en "\033[1;"$thick_horizontal_left"H"; echo -n "═"
	echo -en "\033[1;"$thick_horizontal_right"H"; echo -n "═"
	echo -en "\033["$terminal_height";"$thick_horizontal_left"H"; echo -n "═"
	echo -en "\033["$terminal_height";"$thick_horizontal_right"H"; echo -n "═"

	let "thick_horizontal_left--"
	let "thick_horizontal_right++"

	sleep $1
done

#Draw corners

echo -en "\033[1;1H"; echo -n "╔"
echo -en "\033["$terminal_height";1H"; echo -n "╚"
echo -en "\033["$terminal_height";"$terminal_width"H"; echo -n "╝"
echo -en "\033[1;"$terminal_width"H"; echo -n "╗"

#Draw left and right

let "thick_vertical_top++"
let "thick_vertical_bottom--"

for ((i=1; i<=$thick_vertical_middle; i++))
do
	echo -en "\033["$thick_vertical_top";1H"; echo -n "║"
	echo -en "\033["$thick_vertical_bottom";1H"; echo -n "║"
	echo -en "\033["$thick_vertical_top";"$terminal_width"H"; echo -n "║"
	echo -en "\033["$thick_vertical_bottom";"$terminal_width"H"; echo -n "║"

	let "thick_vertical_top++"
	let "thick_vertical_bottom--"

	sleep $2
done

if ((terminal_height%2))
then
	echo -en "\033["$thick_vertical_middle";1H"; echo -n "║"
	echo -en "\033["$thick_vertical_middle";"$terminal_width"H"; echo -n "║"
fi

# Draw inner thin lined box, if terminal is higher then the ASCII-movie

if (($thin_horizontal_middle))
then
	echo -en "\033["$thin_horizontal_top_start";"$thin_horizontal_left"H"; echo -n "╟"
	echo -en "\033["$thin_horizontal_top_start";"$thin_horizontal_right"H"; echo -n "╢"
	echo -en "\033["$thin_horizontal_bottom_start";"$thin_horizontal_left"H";echo -n "╟"
	echo -en "\033["$thin_horizontal_bottom_start";"$thin_horizontal_right"H"; echo -n "╢"

	let "thin_horizontal_left++"
	let "thin_horizontal_right--"

	for ((i=1; i<=$thin_horizontal_middle; i++))
	do
		echo -en "\033["$thin_horizontal_top_start";"$thin_horizontal_left"H"; echo -n "─"
		echo -en "\033["$thin_horizontal_top_start";"$thin_horizontal_right"H"; echo -n "─"
		echo -en "\033["$thin_horizontal_bottom_start";"$thin_horizontal_left"H"; echo -n "─"
		echo -en "\033["$thin_horizontal_bottom_start";"$thin_horizontal_right"H"; echo -n "─"

		let "thin_horizontal_left++"
		let "thin_horizontal_right--"

		sleep $1
	done

	if (($terminal_width%2))
	then
		echo -en "\033["$thin_horizontal_top_start";"$thin_horizontal_middle"H"; echo -n "─"
		echo -en "\033["$thin_horizontal_bottom_start";"$thin_horizontal_middle"H"; echo -n "─"
	fi

fi

if (($thin_vertical_middle))
then
	echo -en "\033["$thin_vertical_top";"$thin_vertical_left_start"H"; echo -n "╤"
	echo -en "\033["$thin_vertical_top";"$thin_vertical_right_start"H"; echo -n "╤"
	echo -en "\033["$thin_vertical_bottom";"$thin_vertical_left_start"H";echo -n "╧"
	echo -en "\033["$thin_vertical_bottom";"$thin_vertical_right_start"H"; echo -n "╧"

	let "thin_vertical_top++"
	let "thin_vertical_bottom--"

	for ((i=1; i<=$thin_vertical_middle; i++))
	do
		if (($thin_horizontal_middle && $thin_vertical_middle ))&&(($thin_vertical_top == $thin_horizontal_top_start))
		then
			echo -en "\033["$thin_horizontal_top_start";"$thin_vertical_right_start"H"; echo -n "┼"
			echo -en "\033["$thin_horizontal_bottom_start";"$thin_vertical_right_start"H"; echo -n "┼"
			echo -en "\033["$thin_horizontal_top_start";"$thin_vertical_left_start"H";echo -n "┼"
			echo -en "\033["$thin_horizontal_bottom_start";"$thin_vertical_left_start"H"; echo -n "┼"
			
			if ! (( $terminal_height%2))
			then
				let "thin_vertical_bottom--"
			fi
			let "thin_vertical_top++"
			case_tm=1
		fi
		echo -en "\033["$thin_vertical_top";"$thin_vertical_left_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_top";"$thin_vertical_right_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_bottom";"$thin_vertical_left_start"H";echo -n "│"
		echo -en "\033["$thin_vertical_bottom";"$thin_vertical_right_start"H"; echo -n "│"


		let "thin_vertical_top++"
		let "thin_vertical_bottom--"

		sleep $1
	done

	if (($terminal_height%2))
	then
		echo -en "\033["$thin_vertical_middle";"$thin_vertical_left_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_middle";"$thin_vertical_right_start"H"; echo -n "│"
	fi
fi

echo -en "\033[1;1H"
}

drawbox_quick () {

horizonthal_line_thin="──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
horizonthal_line_thick="═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════"; 

echo -en "\033[1;1H"
printf '%s' "${horizonthal_line_thick:0:${COLUMS:-$terminal_width}}"

echo -en "\033["$terminal_width";1H"
printf '%s' "${horizonthal_line_thick:0:${COLUMS:-$terminal_width}}"

for ((i=2; i<=$terminal_height; i++))
do
	echo -en "\033["$thick_vertical_top";1H"; echo -n "║"
	echo -en "\033["$thick_vertical_top";"$terminal_width"H"; echo -n "║"
	
	let "thick_vertical_top++"
done

echo -en "\033[1;1H"; echo -n "╔"
echo -en "\033["$terminal_width";1H"; echo -n "╚"
echo -en "\033["$terminal_width";"$terminal_width"H"; echo -n "╝"
echo -en "\033[1;"$terminal_width"H"; echo -n "╗"

if (($thin_horizontal_middle))
then
	echo -en "\033["$thin_horizontal_top_start";1H"
	printf '%s' "${horizonthal_line_thin:0:${COLUMS:-$terminal_width}}"

	echo -en "\033["$thin_horizontal_bottom_start";1H"
	printf '%s' "${horizonthal_line_thin:0:${COLUMS:-$terminal_width}}"

	echo -en "\033["$thin_horizontal_top_start";1H"; echo -n "╟"
	echo -en "\033["$thin_horizontal_bottom_start";1H"; echo -n "╟"
	echo -en "\033["$thin_horizontal_top_start";"$terminal_width"H"; echo -n "╢"
	echo -en "\033["$thin_horizontal_bottom_start";"$terminal_width"H"; echo -n "╢"
fi

if (($thin_vertical_middle))
then
	echo -en "\033[1;"$thin_vertical_left_start"H"; echo -n "╤"
	echo -en "\033[1;"$thin_vertical_right_start"H"; echo -n "╤"
	echo -en "\033["$terminal_height";"$thin_vertical_left_start"H";echo -n "╧"
	echo -en "\033["$terminal_height";"$thin_vertical_right_start"H"; echo -n "╧"

	let "thin_vertical_top++"
	let "thin_vertical_bottom--"

	for ((i=1; i<=$thin_vertical_middle; i++))
	do
		if (($thin_horizontal_middle && $thin_vertical_middle ))&&(($thin_vertical_top == $thin_horizontal_top_start))
		then
			echo -en "\033["$thin_horizontal_top_start";"$thin_vertical_right_start"H"; echo -n "┼"
			echo -en "\033["$thin_horizontal_bottom_start";"$thin_vertical_right_start"H"; echo -n "┼"
			echo -en "\033["$thin_horizontal_top_start";"$thin_vertical_left_start"H";echo -n "┼"
			echo -en "\033["$thin_horizontal_bottom_start";"$thin_vertical_left_start"H"; echo -n "┼"
			
			if ! (( $terminal_height%2))
			then
				let "thin_vertical_bottom--"
			fi
			let "thin_vertical_top++"
			case_tm=1
		fi
		echo -en "\033["$thin_vertical_top";"$thin_vertical_left_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_top";"$thin_vertical_right_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_bottom";"$thin_vertical_left_start"H";echo -n "│"
		echo -en "\033["$thin_vertical_bottom";"$thin_vertical_right_start"H"; echo -n "│"

		let "thin_vertical_top++"
		let "thin_vertical_bottom--"
	done

	if (($terminal_height%2))
	then
		echo -en "\033["$thin_vertical_middle";"$thin_vertical_left_start"H"; echo -n "│"
		echo -en "\033["$thin_vertical_middle";"$thin_vertical_right_start"H"; echo -n "│"
	fi
fi
}


