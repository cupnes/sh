#!/bin/bash
nr_lvds1=$(xrandr | awk '
	BEGIN{
		FS = " ";
	}
	$1~/LVDS1/{
		print NR;
		exit 0;
	}')
echo "nr_lvds1:$nr_lvds1"

nr_vga1=$(xrandr | awk '
	BEGIN{
		FS = " ";
	}
	$1~/VGA1/{
		print NR;
		exit 0;
	}')
echo "nr_vga1:$nr_vga1"

mode_lvds1=$(xrandr | sed -n "$((${nr_lvds1} + 1))p" | awk '{print $1}')
echo "mode_lvds1:$mode_lvds1"
