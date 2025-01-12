# MariaDB Monitor

A simple bash script to monitor the MariaDB service. The script checks if MariaDB is running, and if it detects that the service has gone down, it attempts to restart it automatically. Logs of these actions are maintained for easy debugging and monitoring.

## Features
- Monitors MariaDB service status.
- Automatically restarts MariaDB if it's not running.
- Logs all actions to `/var/log/mariadb_monitor.log`.
- Configurable check interval.

## Requirements
- Bash (v4 or higher)
- System with `systemctl` for service management (e.g., most Linux distributions with systemd).
- MariaDB installed and running as a service.

## Installation
1. Clone this repository:
    ```bash
    git clone https://github.com/<your-username>/mariadb-monitor.git
    cd mariadb-monitor
    ```

2. Make the script executable:
    ```bash
    chmod +x mariadb_monitor.sh
    ```

3. (Optional) Move the script to a directory in your `PATH` for easier usage:
    ```bash
    sudo mv mariadb_monitor.sh /usr/local/bin/mariadb_monitor
    ```

## Usage
Run the script to start monitoring MariaDB:
```bash
./mariadb_monitor.sh
```

Or, if you moved it to `/usr/local/bin`:
```bash
mariadb_monitor
```

### Run in the Background
To keep the script running even after closing the terminal, use:
```bash
nohup ./mariadb_monitor.sh &
```

Alternatively, you can use a tool like `screen` or set it up as a systemd service (see below).

## Logs
All actions are logged to `/var/log/mariadb_monitor.log`. Make sure the user running the script has permission to write to this file.

## Systemd Service Setup (Optional)
To run the monitor script as a systemd service:

1. Create a new service file:
    ```bash
    sudo nano /etc/systemd/system/mariadb-monitor.service
    ```

2. Add the following content:
    ```ini
    [Unit]
    Description=MariaDB Monitor Script
    After=network.target mariadb.service

    [Service]
    ExecStart=/path/to/mariadb_monitor.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

3. Reload systemd and enable the service:
    ```bash
    sudo systemctl daemon-reload
    sudo systemctl enable mariadb-monitor
    sudo systemctl start mariadb-monitor
    ```

## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
