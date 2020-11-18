#!/bin/bash
echo
cat <<EOF
         _____________     _____               ______
         ______  /__(_)______  /_      ___________  /________  __
         _  __  /__  /_  _ \  __/_________  __ \_  /_  _ \_  |/_/
         / /_/ / _  / /  __/ /_ _/_____/_  /_/ /  / /  __/_>  <
         \__,_/  /_/  \___/\__/        _  .___//_/  \___//_/|_|
                                       /_/
EOF
echo
cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     Diet-Plex     |     Extensive Plex Maintenance     |      v1.2.1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                  https://github.com/morganzero/diet-plex/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

plexdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/"
plexsize=$(du -hs "$plexdir" | cut -f1)

metadatadir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Metadata/"
if [ -d "$metadatadir" ]
then
metadatasize=$(du -hs "$metadatadir" | cut -f1)
echo "Metadata           :  $metadatasize"
fi
mediadir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Media/"
if [ -d "$mediadir" ]
then
mediasize=$(du -hs "$mediadir" | cut -f1)
echo "Contributed Media  :  $mediasize"
fi
transcoderdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Cache/PhotoTranscoder/"
if [ -d "$transcoderdir" ]
then
transcodersize=$(du -hs "$transcoderdir" | cut -f1)
echo "PhotoTranscoder    :  $transcodersize"
fi
syncdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Cache/Transcode/Sync+/"
if [ -d "$syncdir" ]
then
syncsize=$(du -hs "$syncdir" | cut -f1)
echo "Synced Media       :  $syncsize"
fi
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

echo

dir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/"
find "$dir" -type d > metafolders.txt
eplist="metafolders.txt"
total=$(cat $eplist | wc  -l)
BAR='████████████████████████████████████████████████████████████████'
sleep 1
echo
echo "Losing overweight:"
functionx () {
while IFS= read -r line
do
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.thetvdb".*"thumbs".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.localmedia".*"thumbs".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.thetvdb".*"posters".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.themoviedb".*"posters".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.imdb".*"posters".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.localmedia".*"posters".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.thetvdb".*"art".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.themoviedb".*"art".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.imdb".*"art".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"com.plexapp.agents.localmedia".*"art".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Metadata"*.*"bundle".*"Uploads".* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Media"*.*"thumbs*.jpg"* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Media"*.*"index-sd.bif"* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi
if [[ "$line" =~ .*"Media"*.*"chapter.jpg"* ]]; then rm -rf "$line" | tee -a ./dietplex.log; fi


counter=$((counter+1))
x=$(echo $(bc <<<"scale=2; $counter / $total * 100"))
int=${x%.*}
echo -ne "\r|${BAR:0:$int} $x%|"
done < "$eplist"

rm metafolders.txt

}
functionx

sleep 1

echo
echo

echo "🏆 Diet succeeded! Weight reached: $metadatasize"

echo
echo

sleep 1

while true; do

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 Wanna lose additional $transcodersize?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      [Y]  :   Yes remove it!
      [N]  :   No, leave it!

Disclaimer: Cleaning this cache is very effective. A possible downside is
longer loading time when browsing to an item or a library which got its
cached images erased.

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
EOF

sleep 2
syncdir="/opt/appdata/plex/database/Library/Application Support/Plex Media Server/Cache/Transcode/Sync+/"
if [ -d "$syncdir" ]
then
syncsize=$(du -hs "$syncdir" | cut -f1)
while true; do

cat <<EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Synced items are using: $syncsize - Wanna get rid of them?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    [Y]  :   Yeah, burn 'em! 🔥
    [N]  :   Nah, it's okay!


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -r -p "↘️  Make your choice | Type Y/N and press [ENTER]:  " thisisit
echo
    case $thisisit in
        [yY]* ) find "$syncdir" -mindepth 1 -exec rm -r {} \; && echo "Done!"; break;;
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
