# PLAIF Drink Picker

## Description

로봇을 조작하여 원하는 음료수를 뽑는 애플리케이션

## Screenshots

음료 선택 대기
![음료 선택 대기](/docs/screenshots/ready_2.png)

3번 음료 선택
![음료 선택](/docs/screenshots/busy_for_3.png)

로봇과 연결하기
![연결](/docs/screenshots/connect.png)

로봇과 연결 종료
![연결 종료](/docs/screenshots/disconnect.png)

## Tech Stack

- Application: `Flutter`

## Code Structure

`/lib` 을 기준으로 설명

### 1. 전체 구조 에서 설명

```plaintext
lib
├─ core
├─ 기능 1
├─ ...
└─ 기능 n
```

- `core`: 모든 기능에서 공통적으로 사용하는 기능
- `기능 n`: 특정 기능과 관련된 코드(e.g. 기기 연결, 물체 집기)

### 2. 기능 구조 에서 설명

[Eric Evans](https://www.linkedin.com/in/ericevansddd/) 가 [Domain Driven Design](https://www.yes24.com/Product/Goods/5312881) 에서 제시한 구조를 일부 차용한 구조

#### 차이점?

- [Eric Evans](https://www.linkedin.com/in/ericevansddd/) 가 제시한 방법은 각 기능을 모두 `Domain`, `Application`, `Infrastructure`, `Presentation` 으로 분리하고 각각에 맞는 코드들을 모두 모아 총 4개의 모듈로 만들어서 사용하지만, 이 프로젝트에서는 하나의 서비스 안에 각 기능을 분리하고 그 안에서 4 개의 영역으로 분리하여 코드 작성

```plaintext
✨ 특정 기능명(e.g. connection)
├─ application
├─ domain
├─ infrastructure
└─ presentation
```

- `application`: 애플리케이션 로직과 관련된 코드가 모여있는 곳
- `domain`: 비즈니스 로직이 구현된 핵심부
- `infrastructure`: 외부 관심사가 실제로 구현된 곳(e.g. Database 접근)
- `presentation`: 화면에 보여지는 부분과 관련된 코드가 모여있는 곳

## 기타 문서

- [로봇 상태 확인 요청](/docs/apis/websocket_requests/io_states.md)
- [음료 운반 요청](/docs/apis/websocket_requests/set_io.md)
