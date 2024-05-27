# KEEP UP - 바른 자세 알리미
![Frame 2](https://github.com/HJEHA/KEEP-UP/assets/98801129/ce51ac3e-81d8-4dc1-8ef6-57663474f25a)


<img src="https://github.com/HJEHA/KEEP-UP/assets/98801129/481e5a89-53b6-4daa-8ccd-2ddfe87143f4" width="100" height="100">

## 4 Layer
- Feature: 기능
- Domain: 모델
- Core: 템플릿
- Shared: 공용 모듈

## Target Type
- Example: 샘플 앱
- Implement: 구현부
- Tests: 테스트
- Testing: 테스트를 위한 목업
- Interface: 인터페이스

## Dependencies Graph
![graph](https://github.com/HJEHA/KEEP-UP/assets/98801129/70cb29cf-167d-4c1b-a43c-bc09dbe2120e)

## 구동 화면
### 온보딩
<image src="https://github.com/HJEHA/KEEP-UP/assets/98801129/8586a97c-c4d8-41da-9a20-4a375a1a23b5" width="240">

### 측정
<image src="https://github.com/HJEHA/KEEP-UP/assets/98801129/1140bddb-5959-4287-850a-46394853f425" width="240">

### 마이페이지
<image src="https://github.com/HJEHA/KEEP-UP/assets/98801129/21771125-d3bf-48e1-b438-b4eb25d55deb" width="240">

### 사진 및 타임랩스 저장
<image src="https://github.com/HJEHA/KEEP-UP/assets/98801129/ff6a70c4-fe02-4c36-931b-06d4f5d88b7e" width="240">

## 구현 내용
### Microfeatures Architecture
하나의 모듈을 Example(데모 앱, 옵션), Tests(테스트, 옵션), Testing(테스트를 위한 목업, 옵션), Implement(구현부), Interface(인터페이스) 5가지의 타입으로 분리했습니다.

각각의 타겟으로 나눠 타켓별 역할이 명확해지고 결합도를 낮춰 간결한 API를 설계할 수 있습니다.

같은 레이어 내부 모듈간 Interface(인터페이스)만 의존해 수평적인 의존성 구조를 구축할 수 있습니다.

KEEP UP 예로 Feature 레이어 내부의 Onboarding 모듈의 프로필 설정과 아바타 설정 기능이 MyPage 모듈에서도 필요했기 때문에 아래와 그림과 의존성을 구성하였습니다.

![Group 64](https://github.com/HJEHA/KEEP-UP/assets/98801129/740ee265-f974-4a65-9a31-03f5dd82ce22)

위와 같이 구성하면 MyPage 모듈 상위 레이어에서 Onboarding 구현체를 주입받고 Onboarding 모듈의 구현체를 몰라도 Onboarding 모듈 기능을 사용할 수 있습니다.

### 측정 중 캡처 이미지 다운사이징 및 원본 이미지 저장 방법
KEEP UP은 측정 중 3초에 한번씩 이미지를 캡처해 측정 과정을 이미지 또는 타입랩스 동영상으로 저장할 수 있는 기능이 구현되어 있습니다.

이미지를 저장하는 과정에서 원본 이미지의 크기가 너무 커 메모리에 저장할 경우 메모리 오버플로우가 발생할 수 있는 상황이였습니다.

따라서 원본 이미지의 크기를 다운샘플링 후 썸네일 이미지로 사용하고, 원본 이미지의 경우 디스크 캐시를 활용하여 저장하였습니다.

이미지 생성 날짜을 ms 단위까지 문자열로 변환해 원본 이미지 디스크 캐시의 Key로 사용하였습니다.

![Frame 2 (2)](https://github.com/HJEHA/KEEP-UP/assets/98801129/07effca8-ed9d-472a-be52-b41cbdb05c7b)

총 메모리 사용량이 약 9.81% 감소했으며 ARKit을 사용하기 위한 메모리 약 350MB를 제외하면 더 많은 메모리 사용량 감소 효과가 나타날 것으로 보입니다.
