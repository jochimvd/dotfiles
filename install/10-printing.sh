#!/usr/bin/env bash

paru -S --noconfirm --needed cups cups-browsed avahi nss-mdns

# Let Avahi handle mDNS so network printers can be discovered and resolved.
sudo mkdir -p /etc/systemd/resolved.conf.d
sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf >/dev/null <<'EOF'
[Resolve]
MulticastDNS=no
EOF

if ! grep -q 'mdns_minimal' /etc/nsswitch.conf; then
    sudo sed -i \
        's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve files myhostname dns/' \
        /etc/nsswitch.conf
fi

# Automatically register driverless IPP printers advertised on the network.
sudo tee /etc/cups/cups-browsed.conf >/dev/null <<'EOF'
CreateRemotePrinters Yes
EOF

sudo systemctl restart systemd-resolved.service
sudo systemctl enable --now cups.service avahi-daemon.service cups-browsed.service
