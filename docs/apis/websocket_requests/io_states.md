# /ur_hardware_interface/io_states

> 본 내용은 로봇(UR5)에 Websocket을 이용하여 특정 요청을 보내기 위한 명세를 담고 있습니다.

## Description

UR 에서 Input/Output 결과를 받아오는 요청

- 음료수 운반작업이 완료되었는지 아닌지 확인하기 위해 사용함

## Type

Topic - Subscribe

## Request format

```json
{
    "op" : "subscribe",
    "topic" : "/ur_hardware_interface/io_states",
    "type" : "ur_msgs/IOStates"
}
```

## Result

- Example

```json
{
    "topic": "/ur_hardware_interface/io_states",
    "msg": {
        "flag_states": [],
        "analog_out_states": [
            {"domain": 0, "state": 0.004000000189989805, "pin": 0},
            {"domain": 0, "state": 0.004000000189989805, "pin": 1}
        ],
        "digital_out_states": [
            {"state": false, "pin": 0},
            {"state": false, "pin": 1},
            {"state": false, "pin": 2},
            {"state": false, "pin": 3},
            {"state": false, "pin": 4},
            {"state": false, "pin": 5},
            {"state": false, "pin": 6},
            {"state": false, "pin": 7},
            {"state": false, "pin": 8},
            {"state": false, "pin": 9},
            {"state": false, "pin": 10},
            {"state": false, "pin": 11},
            {"state": false, "pin": 12},
            {"state": false, "pin": 13},
            {"state": false, "pin": 14},
            {"state": false, "pin": 15},
            {"state": false, "pin": 16},
            {"state": false, "pin": 17}
        ],
        "digital_in_states": [
            {"state": false, "pin": 0},
            {"state": false, "pin": 1},
            {"state": false, "pin": 2},
            {"state": false, "pin": 3},
            {"state": false, "pin": 4},
            {"state": false, "pin": 5},
            {"state": false, "pin": 6},
            {"state": false, "pin": 7},
            {"state": false, "pin": 8},
            {"state": false, "pin": 9},
            {"state": false, "pin": 10},
            {"state": false, "pin": 11},
            {"state": false, "pin": 12},
            {"state": false, "pin": 13},
            {"state": false, "pin": 14},
            {"state": false, "pin": 15},
            {"state": true, "pin": 16},
            {"state": false, "pin": 17}
        ],
        "analog_in_states": [
            {"domain": 1, "state": -0.0, "pin": 0},
            {"domain": 1, "state": -0.0, "pin": 1}
        ]
    },
    "op": "publish"
}
```
