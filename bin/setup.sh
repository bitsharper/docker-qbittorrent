#!/bin/bash

generate_password() {
    # Not set at all, give the user a random pass
    local generated_pwd=$(tr -dc '_A-Za-z0-9!"#$%&<=>?@[\]^' < /dev/urandom | head -c 14)
    echo $generated_pwd
}

if [ -z "$QBIT_WEBUI_PASS" ]; then
    echo "WebUI password not specified. Generating and encrypting a password."
    QBIT_WEBUI_PASS=$(generate_password)
    echo "qBittorent Web UI has been generated: $QBIT_WEBUI_PASS"
    QBIT_WEBUI_PASS=$(python3 /tmp/qbittorrent/pbkdf2_encryption.py $QBIT_WEBUI_PASS)
else
    echo "Encrypting WebUI password."
    QBIT_WEBUI_PASS=$(python3 /tmp/qbittorrent/pbkdf2_encryption.py $QBIT_WEBUI_PASS)
fi

if [ ! -f "$QBIT_CONFIG_PATH" ]; then
    mkdir -p "$(dirname $QBIT_CONFIG_PATH)"
    cat << EOF > "$QBIT_CONFIG_PATH"
[BitTorrent]
Session\DefaultSavePath=/downloads
Session\Port=6881
Session\TempPath=/downloads/temp

[Preferences]
Downloads\PreAllocation=false
Downloads\SavePath=/opt/qbittorrent/download/
Downloads\ScanDirsV2=@Variant(\0\0\0\x1c\0\0\0\0)
Downloads\StartInPause=false
Downloads\TempPath=/opt/qbittorrent/download/
Downloads\TempPathEnabled=true
WebUI\Address=*
WebUI\AlternativeUIEnabled=false
WebUI\AuthSubnetWhitelist=@Invalid()
WebUI\AuthSubnetWhitelistEnabled=false
WebUI\CSRFProtection=true
WebUI\ClickjackingProtection=true
WebUI\HTTPS\Enabled=false
WebUI\HostHeaderValidation=true
WebUI\LocalHostAuth=true
WebUI\Port=8080
WebUI\RootFolder=
WebUI\ServerDomains=*
WebUI\UseUPnP=true
WebUI\Username=admin
WebUI\Password_PBKDF2="@ByteArray($QBIT_WEBUI_PASS)"
[LegalNotice]
Accepted=true
EOF
fi