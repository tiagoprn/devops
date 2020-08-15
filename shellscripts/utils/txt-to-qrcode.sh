#!/bin/sh

# reference: https://gist.github.com/wis/04f98ad8c82d10966ca135de5a241d18

usage="USAGE:\n
\t$0 path/to/file.txt [OPTIONS]\n
OPTIONS:\n
\t--help displays this message\n
\t--size default 10\n
\t--dpi default 300\n
\t--foreground default 000000, format RRGGBB or RRGGBBAA\n
\t--background default FFFFFF, format RRGGBB or RRGGBBAA\n
\t--level default M, available L,M,Q,H\n
\t--prefix default \"qr-\"\n
\t--symversion default \"auto\", available 1 to 40\n
\t--type default PNG, available PNG,EPS,SVG,ANSI,ANSI256,ASCII,ASCIIi,UTF8,ANSIUTF8"

# "Symbol Version"
# The symbol versions of QR Code range from Version 1 to Version 40. Each version has a different module configuration or number of modules. (The module refers to the black and white dots that make up QR Code.)
# "Module configuration" refers to the number of modules contained in a symbol, commencing with Version 1 (21 × 21 modules) up to Version 40 (177 × 177 modules). Each higher version number comprises 4 additional modules per side.
# Each QR Code symbol version has the maximum data capacity according to the amount of data, character type and error correction level.　In other words, as the amount of data increases, more modules are required to comprise QR Code, resulting in larger QR Code symbols.
# "Error correction"
# QR Code has error correction capability to restore data if the code is dirty or damaged. Four error correction levels are available (from L to H) for users to choose according to the operating environment. Raising this level improves error correction capability but also increases the amount of data QR Code size.
# To select error correction level, various factors such as the operating environment and QR Code size need to be considered. Level Q or H may be selected for factory environment where QR Code get dirty, whereas Level L may be selected for clean environment with the large amount of data. Typically, Level M (15%) is most frequently selected.


if [ ! $# -eq 0 ] ; then

    param=$1
    error=1
    if [ $1 = "--help" ]; then
        echo -e $usage
        exit 1
    elif [ ! -f $param ] ; then
        # No such file
        echo "Error: File \"$param\" does not exist or is not readable."
        exit 1
    fi

    # Defaults, (see man qrencode)
    siz="10"
    dpi="300"
    fgd="000000"
    bgd="ffffff"
    lvl="M"
    pfx="qr-"
    sym="40"
    ext="png"

    for i in "$@"; do case $i in
        --size=*)       siz="${i#*=}";;
        --dpi=*)        dpi="${i#*=}";;
        --foreground=*) fgd="${i#*=}";;
        --background=*) bgd="${i#*=}";;
        --level=*)      lvl="${i#*=}";;
        --prefix=*)     pfx="${i#*=}";;
        --symversion=*) sym="${i#*=}";;
        --type=*)       ext="${i#*=}";;
    esac
    done

    if ! type qrencode > /dev/null ; then
        # qrencode is not present in PATH
        echo "Error: qrencode is not installed. Please install qrencode first."
        exit 1
    fi

    total_chars=$(wc -m < $param);
    total_lines=$(wc -l < $param);
    proceed=false
    if [ $total_chars -gt 0 ]; then
        echo -n "Reading: \"$param\" with $total_chars characters."
        # Maximum resolution at level H can do 1852 alphanumeric chars
        if [ $total_chars -lt 1852 ]; then
            chunks=0
            echo "Only one QR code will be necessary"
        else
            rounded=$((($total_chars + 1852 - 1) / 1852));
            chunks=$((($total_lines + $rounded - 1) / $rounded));
            echo "$rounded QR codes will be necessary"
        fi
    else
        echo "Error: Empty input file?"
        exit 1
    fi

    qr_part=1
    if [ $chunks -gt 0 ]; then
        line_count=0
        while IFS= read -r line || [ -n "$line" ]; do
            line_count=$((line_count + 1))
            lines="$lines"'\n'"$line"
            if [ $line_count -eq $chunks ]; then
                # Make QR code.
                echo -n "\ncreating $pfx$qr_part.$ext..."
                echo -n $lines | qrencode -s $siz -d $dpi --foreground=$fgd --background=$bgd -l $lvl -v $sym -t $ext -o $pfx$qr_part.$ext
                lines=""
                line_count=0
                qr_part=$((qr_part + 1))
            fi
        done < "$param";
        # If not empty encode the last bit
        if ! [ -z "$lines" ]; then
            # Make QR code.
            echo -n "\ncreating $pfx$qr_part.$ext..."
            echo -n $lines | qrencode -s $siz -d $dpi --foreground=$fgd --background=$bgd -l $lvl -v $sym -t $ext -o $pfx$qr_part.$ext

        fi
    else
        echo -n "\ncreating $pfx$qr_part.$ext..."
        cat $param | qrencode -s $siz -d $dpi --foreground=$fgd --background=$bgd -l $lvl -v $sym -t $ext -o $pfx$qr_part.$ext
    fi
else
    echo $usage
    exit 1
fi
