self: super: {
  toggle_bt_device = super.writeShellApplication {
    name = "toggle_bt_device";

    text = ''
      mac_address="$1"
      
      # Get the connection status of the device
      connection_status=$(bluetoothctl info "$mac_address" | grep "Connected:" | awk '{print $2}')
      
      if [ "$connection_status" == "yes" ]; then
        status="connected"
      else
        status="disconnected"
      fi
      
      # If device connected, disconnect it
      if [ "$connection_status" == "yes" ]; then
        status="disconnected"
        echo "disconnect $mac_address " | bluetoothctl
      else    # If device disconnected, connect to it
        status="connected"
        echo "connect $mac_address " | bluetoothctl
      fi
      
      echo "Device $mac_address is now $status"
    '';
  };
}
