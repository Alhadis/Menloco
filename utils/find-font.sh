#!/bin/sh

# Echoes the full path of the first font whose filename contains a given string
find_font(){

	# List of directories used on Mac OS to store fonts
	# Source: https://support.apple.com/en-au/HT201722
	#
	# We're searching in *reverse* order to ensure we don't pick up a modified copy
	# of $font_name from a user directory. Unlikely, but could happen.
	font_paths=(
		/System\ Folder/Fonts/
		/System/Library/Fonts/
		/Network/Library/Fonts/
		/Library/Fonts/
		"$HOME/Library/Fonts/"
	);


	# Search through each system path in search of $font_name
	for i in "${font_paths[@]}"; do
		matches=$(ls -1 "$i" 2>/dev/null | grep $font_name)
		
		# Files containing the font's name exist in this directory
		[ $? -eq 0 ] && {
			matches=($matches)

			# Cycle through each font and return the first one that's of a valid format
			for m in "${matches[@]}"; do
				file="${i}${m}";
				
				# Verify the file's readable and that it's actually of a proper font format
				[ ! -r "$file" ] && { >&2 echo "Skipping unreadable file: $file"; } || {
					
					# Open/close the file with FontForge
					fontforge -nosplash -lang=ff -c 'Open($1); Close();' "$file" 2>/dev/null;
					
					# If it opened okay, it's obviously legit font material. Go for it.
					[ $? -eq 0 ] && { echo "$file"; exit 0; }
					
					>&2 echo "Not a font file: $file";
				}
			done;
		};
	done;

	>&2 printf 'Failed to locate font "%s"\n' $font_name
	exit 1;
}



# Label our arguments with something more readable
font_name=$1
copy_to=$2


# Find where the queried font lives
path=$(find_font "$font_name" 2>/dev/null)


# Make sure we found something before continuing
[ $? -eq 0 ] && {
	mkdir -p $(dirname $copy_to)
	
	file "$path" | grep -iE '(Open|True)Type' | grep -vi 'font collection' && {
		cp "$path" $copy_to;
	} || {
		fontforge -nosplash -lang=ff -c 'Open($1); Generate($2);' 2>/dev/null "$path" $copy_to
	};
};
