#!/bin/bash
#                               .___                     
#     ___________    _____    __| _/__  ___              
#    /  ___/\__  \  /     \  / __ |\  \/  /              
#    \___ \  / __ \|  Y Y  \/ /_/ | >    <               
#   /____  >(____  /__|_|  /\____ |/__/\_ \              
#        \/      \/      \/      \/      \/              

# http://patorjk.com/software/taag/#p=display&f=Graffiti

# Tue 23 Aug 2016 10:48:47 PM ICT
# Wed 24 Aug 2016 02:00:22 AM ICT

# Check if the source dir is provided, cd to that location unless
# the sourcedir is the current-working-dir.

if [ -n "$1" ]; then
    readonly SOURCEDIR="$1"
    echo -e "\tYOU'VE SPECIFIED THE SOURCE DIR IS:\n"
    echo -e "\t$SOURCEDIR"
    echo -e "\tCD TO THE WORKDIR"
    cd "$SOURCEDIR"
else
    echo -e "\tYOU'VE NOT SPECIFIED THE SOURCE DIR."
    echo -e "\tTHEN THE SOURCE DIR IS THE CURRENT-WORKING-DIR."
    SOURCEDIR="$(pwd)"
fi

doc2docx()
{
    # The doc file is the $1.
    DOCFILE="$1"

    echo -e "\tTHE DOC FILE IS: $DOCFILE"
    echo -e "\tI'M GOING TO CONVERT THE DOC TO DOCX FORMAT."
    # Call LIBREOFFICE
    soffice --convert-to "docx" "$DOCFILE"
    echo -e "\tTHE $DOCFILE HAS BEEN CONVERTED SUCCESSFULLY."
    echo -e "\tIT'S READY TO BE REMOVED."
    rm -v "$DOCFILE"
}

relativepath()
{
    FILETOPROCESS="$1"
    CWD=$(pwd)
    # GNU sed only. If your sed does not come with -i, you should copy/rename
    # the file manually
    echo -e "\tMARKDOWN: RELATIVE PATH FOR MEDIA FILES"
    sed -i "s:$CWD/::g" "$FILETOPROCESS"
}

docx2md()
{
    # The docx file is the $1.
    DOCXFILE="$1"

    echo -e "\n"
    MARKDOWNFILE=`basename "$DOCXFILE" docx`md
    echo -e "\tTHE $DOCXFILE FILE WILL BE CONVERT TO:"
    echo -e "\t---> $MARKDOWNFILE <--"
    MEDIADIRNAME=`basename "$DOCXFILE" .docx`-media
    MEDIADIR="$(pwd)/$MEDIADIRNAME"

    if [ ! -d "$MEDIADIR" ]
    then
        echo -e "\n"
        echo -e "\tMAKE NEW FOLDER FOR MEDIA FILES STORING"
        mkdir -pv "$MEDIADIR"
    fi

    # Call PANDOC
    pandoc -f docx -t markdown --extract-media="$MEDIADIR" \
    -o "$MARKDOWNFILE" "$DOCXFILE"
    sleep 2

    # Replace all the media absolute path by the relative path in the markdown
    # output file
    relativepath "$MARKDOWNFILE"
}

convertfiles()
{
    # The working-dir is the $1, cd to that dir
    WORKDIR="$1"
    cd "$WORKDIR"

    echo -e "\t--- CONVERTING FILES IN FOLDER ---"
    echo -e "\t$WORKDIR"
    echo -e "\t--- ========================== ---\n"

    # Loop through all item in the WORKDIR
    for item in *;
    do
        # Replace all space in filename/foldername with hyphen if there is
        case "$item" in
            *\ *)
                item=${item// /-}
                echo -e "\tREMOVE ALL SPACES"
                mv -v "$item" "$itemname"
                ;;
            *)
                item=${item}
                ;;
        esac

        # Convert the unicode charts to us-ascii charts
        # lowercase the item name
        echo -e "\tlowercase ALL THE NAMES"
        echo "$item" > /tmp/tempname
        local tmpname=$(perl -C -MText::Unidecode -n -e'print unidecode( $_ )' /tmp/tempname)
        echo "$tempname" > /tmp/tempname
        local tmpname=$(sed -E 's/([[:upper:]])/\L\1/g' /tmp/tempname)

        # Rename the item to new one
        if [ "$item" != "$tmpname" ]
        then
            echo -e "\t--- RENAME ---"
            mv -v "$item" "$tmpname"
            item="$tmpname"
        fi

        # If the item is a dir, cd to it
        if [ -d "$item" ]
        then
            echo -e "\t '$item' IS A SUB DIR"
            # Call the function itself to this folder
            convertfiles "$item"
            # Go back to the father dir
            cd ..
        # If the item is a file, check if it is a doc or docx file
        elif [ -f "$item" ]
        then
            case "$item" in
                *.doc)
                    doc2docx "$item"
                    local docxfile=`basename "item" doc`docx
                    docx2md "$docxfile"
                    ;;
                *.docx)
                    docx2md "$item"
                    ;;
            esac

        fi
    done
}

convertfiles $SOURCEDIR

# TODO
# - pandoc's templates
# - pandoc title block

