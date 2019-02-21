& scoop install bitwarden-cli
& scoop update bitwarden-cli
& bw login brycekbargar@gmail.com
& { $env:BW_SESSION=$(bw unlock --raw) }