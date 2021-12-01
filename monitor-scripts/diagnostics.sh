#!/bin/bash

nebra_fastsync=$(wget -qO- https://helium-snapshots.nebra.com/latest.json | grep -Po '"'"height"'"\s*:\s*\K([^,]*)')

echo $nebra_fastsync > /var/dashboard/statuses/nebra_fastsync