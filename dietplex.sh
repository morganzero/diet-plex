#!/bin/bash
echo "Calculating weight. This might take a while"
sleep 2
echo "Go grab something to drink while you wait."
sleep 2
echo "...maybe something with zero sugar."
sleep 1
plexdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/"
plexsize=$(du -hs "$plexdir" | cut -f1)

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🥋 Plex Diet       |     Extensive Plex Maintenance     |       v1.2
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

metadatadir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Metadata/"
metadatasize=$(du -hs "$metadatadir" | cut -f1)
echo "Metadata           :  $metadatasize"

transcoderdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Cache/PhotoTranscoder/"
transcodersize=$(du -hs "$transcoderdir" | cut -f1)
echo "PhotoTranscoder    :  $transcodersize"

anidbdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Plug-in Support/Data/com.plexapp.agents.hama/DataItems/"
if [ -d "$anidbdir" ]
then
anidbsize=$(du -hs "$anidbdir" | cut -f1)
echo "HAMA (Anidb)       :  $anidbsize"
fi
echo
echo "Total size         :  $plexsize"

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

dir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Metadata/"
find "$dir" -type d > metafolders.txt
eplist=$("metafolders.txt")
total=$(cat $eplist | wc  -l)
BAR='████████████████████████████████████████████████████████████████'
sleep 1
echo
echo "Losing overweight:"
while IFS= read -r line
do
if [[ "$line" =~ .*"com.plexapp.agents.thetvdb".*"thumbs".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.localmedia".*"thumbs".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.thetvdb".*"posters".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.themoviedb".*"posters".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.imdb".*"posters".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.localmedia".*"posters".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.thetvdb".*"art".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.themoviedb".*"art".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.imdb".*"art".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.localmedia".*"art".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"bundle".*"Uploads".* ]]; then rm -rf "$line" -v >> ./dietplex.log; fi

counter=$((counter+1))
x=$(echo $(bc <<<"scale=2; $counter / $total * 100"))
int=${x%.*}
echo -ne "\r|${BAR:0:$int} $x%|"
done < "$eplist"

rm metafolders.txt

sleep 1

echo
echo "🏆 Diet succeeded! Weight reached: $metadatasize"
echo

sleep 1

while true; do

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 Lose additional weight?: $transcodersize
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      [Y]  :   Yes remove it!"
      [N]  :   No, leave it!"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    read -r -p "↘️  Make your choice | Type Y/N and press [ENTER]:  " thisisit
echo
    case $thisisit in
        [yY]* ) rm -r "$transcoderdir"; break;;
        [nN]* ) break;;
        * ) echo
        echo "🔪 Don't be a retard, please chose either Y or N"
        echo;;
    esac
done
sleep 2
anidbdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Plug-in Support/Data/com.plexapp.agents.hama/DataItems/"
if [ -d "$anidbdir" ]
then
anidbsize=$(du -hs "$anidbdir" | cut -f1)
while true; do

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
HAMA is using: $anidbsize
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    [Y]  :   Yeah, slim it down!
    [N]  :   DON'T TOUCH MY HAMA!


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -r -p "↘️  Make your choice | Type Y/N and press [ENTER]:  " thisisit
echo
    case $thisisit in
        [yY]* ) find "$anidbdir" -mindepth 1 -exec rm -r {} \; && echo "Done!"; break;;
        [nN]* ) break;;
        * ) echo "🔪 Don't be a retard, please chose either Y or N";;
    esac
done
fi

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Extreme diet finished.

EOF

sleep 1
echo "Cleaning up ...🧹"
sleep 1
echo

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍻 New Plex Size is  : $plexsize
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
echo
