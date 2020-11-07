#!/bin/bash
plexdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/"
plexsize=$(du -hs "$plexdir" | cut -f1)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🥋 Plex Diet | Extensive Plex Maintenance | Current Plex size: $plexsize  "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
metadatadir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Metadata/"
metadatasize=$(du -hs "$metadatadir" | cut -f1)
echo "Metadata           :  $metadatasize"
transcoderdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Cache/PhotoTranscoder/"
transcodersize=$(du -hs "$transcoderdir" | cut -f1)
echo "PhotoTranscoder    :  $transcodersize"
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
dir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Metadata/"
find "$dir" -type d > metafolders.txt
eplist="metafolders.txt"
total=$(cat $eplist | wc  -l)
BAR='████████████████████████████████████████████████████████████████'
sleep 1
echo
echo "Losing overweight:"
while IFS= read -r line
do
if [[ "$line" =~ .*"com.plexapp.agents.thetvdb".*"thumbs".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.localmedia".*"thumbs".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.thetvdb".*"posters".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.themoviedb".*"posters".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.imdb".*"posters".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.themoviedb".*"art".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"com.plexapp.agents.imdb".*"art".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi
if [[ "$line" =~ .*"bundle".*"Uploads".* ]]; then rm -r "$line" -v >> ./dietplex.log; fi

counter=$((counter+1))
done < "$eplist"
x=$(echo $(bc <<<"scale=2; $counter / $total * 100"))
int=${x%.*}
echo -ne "\r|${BAR:0:$int} $x%|"
rm metafolders.txt
echo
echo
sleep 1
echo
echo "🏆 Diet succeeded! Weightloss: $metadatasize"
echo
sleep 1
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "💡 Lose additional weight?: $transcodersize"
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo
sleep 1
while true; do
    echo " [Y]  :   Yes remove it!"
    echo " [N]  :   No, leave it!"
echo
echo
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    read -r -p "↘️  Type Y/N | Press [ENTER]:" thisisit
echo
    case $thisisit in
        [yY]* ) rm -f "$transcoderdir{*,.*}"; break;;
        [nN]* ) break;;
        * ) echo
        echo "🔪 Don't be a retard, please chose either Y or N"
        echo;;
    esac
done
sleep 2
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo
echo "Extreme diet finished. "
echo
sleep 1
echo "Cleaning up ...🧹"
sleep 1
echo
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo "✅ New Plex Size is: $plexsize"
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo
