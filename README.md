# AnabadaBoard Board [Swift Mini Project 04]
> 당근 앱을 모티브로 하여 데이터를 생성, 수정, 삭제 가능한 게시판 구성. 
> 이미지 슬라이드를 구성하고 필터로 데이터를 최신순,최고가순, 최저가순으로 분류하고, 즐겨찾기 항목만 모아 볼 수 있도록 구성.
> 
> 구현 해 본 기능
> - 스토리보드 없이 코드로 UI 구성
> - Custom Delegate 사용
> - 스크롤뷰를 이용하여 이미지 슬라이드 제작

<img width="30%" title="아나바다 게시판" alt="anabana board" src="https://github.com/dorami4477/BMICalculator/assets/85213387/edbfcd8e-069c-47d1-ac86-1f372f8ce83c">
<img width="30%" title="아나바다 게시판" alt="anabana board" src="https://github.com/dorami4477/BMICalculator/assets/85213387/978479ea-a5c2-43c6-91cb-40eba599a1b4">
<img width="30%" title="아나바다 게시판" alt="anabana board" src="https://github.com/dorami4477/BMICalculator/assets/85213387/349a1ecc-6acc-462d-8fa5-1ae1c860b736">

## 메인화면 요구사항(페이지1)

1. 이미지, 타이틀, 내용, 가격, 하트(관심상품)가 들어간 테이블 뷰를 구성합니다.(데이터는 임의로 구성)
2. 화면 오른쪽 하단에 새로 만들기 버튼 생성합니다. - 클릭시 페이지3 으로 이동
3. 네비게이션 왼쪽 바버튼에 필터 버튼 생성합니다. 버튼을 누르면 셀렉트 박스가 생기고, “최신 순(기본상태), 최고가 순, 최저가 순”으로 버튼이 보여 집니다. 버튼 선택에 따라 셀의 순서가 변경됩니다.  
4. 네비게이션 오른쪽 바버튼에 관심상품 버튼을 생성합니다. 버튼을 누르면 하트를 누른 상품만 보여지며, 채워진 하트로 아이콘이 변합니다.  
5. 셀 클릭시 페이지2로 이동합니다.

--------

<img width="30%" title="아나바다 게시판" alt="anabana board" src="https://github.com/dorami4477/BMICalculator/assets/85213387/0d2fd592-3a3b-4580-91d3-bbe14e106dae">

## 디테일화면 요구사항(페이지2)

1. 이미지 여러개를 슬라이드 형식으로 보여줍니다. (메인화면에서는 대표이미지 1장만 보이도록 함)
2. 메인화면의 데이터를 배치해줍니다.
3. 수정하기 버튼을 하단에 만들고, 버튼 클릭시 수정화면으로 이동합니다.
4. 삭제하기 버튼을 만들고, 버튼을 클릭시 해당 게시물을 삭제합니다.

---------
<img width="30%" title="아나바다 게시판" alt="anabana board" src="https://github.com/dorami4477/BMICalculator/assets/85213387/03f10398-f3fb-47f2-8735-7827b0717505">

## 수정 및 새로운 게시물 생성 화면 요구사항(페이지3)

1. 여러장의 이미지를 업로드 할 수 있으며, 이미지 선택시 선택된 이미지를 나열합니다.
2. 이미지, 타이틀, 설명, 가격의 데이터를 변경 또는 새로 저장 가능하도록 합니다.
