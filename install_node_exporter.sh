useradd --system --shell /bin/false node_exporter

curl -fsSL https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz \
  | tar -zxvf - -C /usr/local/bin --strip-components=1 node_exporter-1.6.1.linux-amd64/node_exporter \
  && chown node_exporter:node_exporter /usr/local/bin/node_exporter


tee /etc/systemd/system/node_exporter.service <<"EOF"
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload && \
systemctl start node_exporter && \
systemctl status node_exporter && \
systemctl enable node_exporter