# /ur_hardware_interface/set_io

> 본 내용은 로봇(UR5)에 Websocket을 이용하여 특정 요청을 보내기 위한 명세를 담고 있습니다.

## Description

UR 에서 Output pin 을 변경하는 요청

- 음료수를 고르는 역할로 사용함

## Type

Topic - Subscribe

## Request format

```json
{
    "op": "call_service",
    "service" : "/ur_hardware_interface/set_io",
    "type" : "ur_msgs/SetIO",
    "args" : { argument below },
}
```

### (1) Arguments

- Example

```json
{
    "fun": 1,
    "pin": index,
    "state": 1.0,

```

## Result

- Example

```json
{
    "id": "call_service:/ur_hardware_interface/io_states:0",
    "values": {"success": true},
    "result": true,
    "service": "/ur_hardware_interface/set_io",
    "op": "service_response"
}
```
