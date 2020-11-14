# diet-plex

Great for users with huge libraries.

A crazy bash script that deletes all duplicate metadata entries in Plex. Leaving only the display cover and art intact and downsizing the DB.

The script is optimized and aligned to work with PTS/PGBlitz. You can edit it to suit your needs.

# Getting started

## Download script
```cd /path/ && git clone https://github.com/morganzero/diet-plex/```

## Make it executable
```chmod +x /path/diet-plex/dietplex.sh```

# Usage

## Run script
```bash /path/diet-plex/dietplex.sh```

## Follow the instructions in the script.

The script will calculate the size of your database and then clean out all duplicate entries of metadata right away. When finished it will ask you to clean out additional weight from: `~/PhotoTranscode`, HAMA, and Synced items that perhaps you or your users have forgotten to remove yourselves.

Enjoy!

# Support

If you want to support me (does not equal development): <br>
<a href="https://www.paypal.com/paypalme/sizemattrs/1" target=blank><img src=http://imgur.com/WSVZSTW.png alt="Buy Me a Coffee" height=75 width=150 align='center'></a> &nbsp;&nbsp; or &nbsp;&nbsp; <a href="https://www.paypal.com/paypalme/sizemattrs/3" target=blank><img src=http://imgur.com/gnvlm6n.jpg alt="Buy Me a Beer" height=75 width=150 align='center'></a>
