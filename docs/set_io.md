# /ur_hardware_interface/set_io

call type: service
data type: ur_msgs/SetIO

## argument

Example

```json
{
    "fun": 1,
    "pin": index,
    "state": 1.0,
}
```

## result

Example

```json
{
    "id": "call_service:/ur_hardware_interface/io_states:0",
    "values": {"success": true},
    "result": true,
    "service": "/ur_hardware_interface/set_io",
    "op": "service_response"
}
```
