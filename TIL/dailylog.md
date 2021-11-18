# DAILY LOG

🟡 [Day1 - 211115](#day1---211115)

🟡 [Day2 - 211116](#day2---211116)

🟡 [Day3 - 211117](#day3---211117)

🟡 [Day4 - 211118](#day4---211118)

<br>

<hr>

## Day1 - 211115

* ### 와이어프레임

<img src="../Screenshots/wireframe.png" alt="basic" height="60%" width="60%;" />

> [색조합](https://colorhunt.co/palette/118df00e2f56ff304fececda)

<br>

* ### 기획

  * 사용자 위치
  * API: 카카오, 네이버지도
  * Realm

| 화면                   | 상세                                                         |
| ---------------------- | ------------------------------------------------------------ |
| **메인**               | - 달별로 확인 가능<br>- 수입 클릭 시 아래 숫자 키보드로 간단하게 입력<br>- *아래 지출 부분만 tableView(collectionView)<br>- selectRowAt: 수정<br>- 삭제<br>- 플로팅버튼 선택 시 입력창 modal fullscreen<br>- *아래 버튼 클릭시 지도뷰(레퍼런스: 현대카드 웨더) or 11월 아래부분 옆으로 스와이프시 |
| **작성/수정**          | - 플로팅 버튼: 입력, cell: 수정<br>- 금액부분에 커서, 키보드 숫자로 바로 띄워주기<br>- 금액 , 처리<br>- 날짜 datePicker (month) |
| **작성/수정-온라인**   | - 온라인 버튼 클릭시, textfield 생기고 키보드 올리기         |
| **작성/수정-오프라인** | - 오프라인 버튼 클릭시, searchController<br>- `카카오API` 키워드로 장소검색하기<br>- 현재위치 기준으로 반경 3키로 내 |
| **지도**               | - 오프라인 결제한곳 띄워주기<br>- `네이버지도API` <br>- custom marker(안되면 그냥 찍기)<br>- 전체보여주기<br>- 현재위치 버튼 좌측 하단 |
| **지도선택**           | - *마커 클릭시, 아래 tableView or collectionView 가로 <br>- 수정, 삭제 가능 |

<br>

<br>

## Day2 - 211116

* [기획서](./projectplan.md) 

<br>

### ⚡️TEAM BUILDING

* 팀원들과 기획을 간단히 공유했다
* 성용님이 뷰가 적다는 피드백을 해주셔서 좀 더 늘려보려고 한다

<br>

<br>

## Day3 - 211117

* [발표자료](./presentation.md) 

* 폰트, 에셋, 컬러 Extension 설정: figma에서 제플린으로 export해왔다. 제플린 쓰니까 엄청 금방 끝났다
* 화면 전환과 관련해서 swipe gesture와 hero라이브러리로 학습 겸 간단한 예제를 만들어보았다

<br>

### ⚡️TEAM BUILDING

* 구체화된 기획과 디자인, 개발공수에 대해서 공유했다

<br>

<br>

## Day4 - 211118

* 메인 뷰에서 월을 선택하게 하는데,이 부분을 어떻게 구현해야 할지 찾다가 3시간 정도 날렸다 
  * 토스처럼 구현하자니 매달 자동으로 새로운 월이 생기도록 해야하는데 .. 음,,
  * 편한가계부에 라이브러리같아 보이는걸 썼길래 당연히 라이브러리가 저렇게 이쁘게 생긴 라이브러리는 못찾겠다 !

<img src="../Screenshots/calendartoss.png" alt="basic" width="30%;" /><img src="../Screenshots/caledarmm.png" alt="basic" width="30%;" />

<br>

### ⚡️TEAM BUILDING

* 경원님이 `attributedText` 에 관한 이슈를 공유해주셨다. 그리고 벌써 뷰를 거의 다 그리셨다고 한다🙊
* 수환님은 기획한 어플과 이름까지 똑같은 앱이 있어서 기획을 수정하신다고 한다
* 다국어 설정을 언제 하는게 맞는건지 조언을 구했다. 경원님께서 미리 해주는게 좋다고 말해주셔서 오늘 하려고 한다
* 팀원 모두 배고파서 금방 끝냈다
* 팀빌딩 이렇게 적어도 되는건지 모르겠다

<br>

<br>
