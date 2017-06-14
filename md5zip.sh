count=`ls -1 *.pdf 2>/dev/null | wc -l`
if [ $count == 0 ]
then
    echo pdf files not found
else
    for x in *.pdf; do
        filename="${x%.*}" #define filename var
        echo filename={"$filename"}, >> md5zip #write filename
        echo filename={"$filename"}, #echo filename
        #
        filesize=$(stat -c%s "$x") # GNU stat get filesize in bytes
        echo filesize={"$filesize"}, >> md5zip #write filsize
        echo filesize={"$filesize"}, #echo filesize
        #
        md5=($(md5sum "$x")) #define md5 var
        echo md5sum={"$md5"}, >> md5zip #write md5sum
        echo md5sum={"$md5"}, #echo md5sum
        #
        sha1=($(sha1sum "$x")) #define sha1 var
        echo sha1sum={"$sha1"}, >> md5zip #write sha1sum
        echo sha1sum={"$sha1"}, #echo sha1sum
        #
        zip -q --password $md5 "$filename.zip" "$x" #zip quiet mod
        zipsize=$(stat -c%s "$filename.zip") # GNU stat get zipsize in bytes
        echo "$filename".zip created "$zipsize"
        #
        echo #blank line
        echo >> md5zip
    done
    ls *.{pdf,zip}
fi
