# Enable linger
```
loginctl enable-linger
```
# Enable WOL
```
sudo systemctl daemon-reload
sudo systemctl enable --now wol.service
```
