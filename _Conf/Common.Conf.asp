<%
CONST SITE_TITLE = "TOMORROW"
CONST SITE_URL = "tml-sk.com"
CONST SITE_DESC = ""
CONST SITE_NAME = "TOMORROW"
CONST SITE_MAIN_USE = True                 ' 싸이트 메인페이지 사용 유무(True : 사용 , False : 비사용) 

CONST IMAGE_URL  = "/img"

'#### 기능 설정
CONST BETTING_ALL = false                   ' 조합 배팅 사용 유무 (True : 조합 , False : 비조합)
CONST BETTING_LIST_TYPE = 2                ' 게임화면 타입 ( 1:시간별 2:리그별)
CONST BETTING_COUNT = 10                    ' 배팅 게임 제한수 (숫자 조절)
CONST BETTING_CANCEL = True                 ' 배팅 취소 기능(True : 사용 , False : 비사용) 
CONST BETTING_CANCEL_TERM = -10              ' 배팅 취소 가능 시간(분 단위) 
CONST BETTING_CANCEL_COUNT = 3              ' 하루 배팅 취소 횟수
CONST BETTING_CANCEL_DATE_TERM = -24              '배팅취소 카운트체크 시간값
CONST BETTING_CANCEL_POINT = 0              '배팅취소시 포인트 차감 ( 0일 경우 사용안함)
CONST BETTING_ONE_MAX       = TRUE          ' 단폴더 제한
COnST GAME_END_TEAM       = 0            ' 배팅 자동 마감 시간 지정

CONST POINT_USE = True                      ' 포인트 적립 (True : 사용 , False : 비사용) 
CONST POINT_MEMBER_JOIN = 0              ' 회원가입시 적립포인트 ( 0 : 사용 안함)
CONST POINT_MEMBER_RECOM = 0             ' 회원가입시 추천인 적립포인트 ( 0 : 사용 안함)
CONST POINT_FREE        = 100              ' 게시판 글씨기 적립포인트 ( 0 : 사용 안함)
CONST POINT_FREE_REPLY  = 50              ' 게시판 글씨기 적립포인트 ( 0 : 사용 안함)
CONST GAME_DATA_LINK  = True              ' 게임 정보 링크
CONST POINT_FREE_COUNT        = 3              ' 게시판 하루 적립포인트 ( 0 : 사용 안함)
CONST POINT_FREE_REPLY_COUNT  = 5              ' 게시판 하루 적립포인트 ( 0 : 사용 안함)

CONST JACKPOT_USE           = False             ' 잭팟 사용 유무
CONST JACKPOT_PERCENT       = 0.01              ' 잭팟으로 쌓일 퍼센트 정리

CONST SUPPORT_CHAT          = False              ' 1:1 채팅기능
CONST SUPPORT_CHAT_ID          = "sjrnfl"              ' 1:1 채팅기능

'####  채팅 설정
CONST CHAT_ROOM = "~~~k2insss_chats"        ' 싸이트 채팅창명
CONST CHAT_ROOM_OPEN = False                 ' 싸이트 채팅 사용 유무(True : 사용 , False : 비사용) 

'#### 싸이트 디자인 설정
CONST SITE_GNB_HEIGHT = 20                  ' GNB 높이 값(숫자 조절)
CONST SITE_COPYRIHGT_HEIGHT = 70            ' 카피라이터 높이 값(숫자 조절)
CONST OVER_IMAGE = "&nbsp;<script language='javascript'>ShowFlash('/flash/arrow_up.swf',20,15)</script>&nbsp;"            ' 오버 이미지
CONST UNDER_IMAGE = "&nbsp;<script language='javascript'>ShowFlash('/flash/arrow_down.swf',20,15)</script>&nbsp;"            ' 언더 이미지
CONST VS_IMAGE      = "<span class='red'>VS</span>"

'####### 게시판 설정
CONST ADMIN_REPLY_USE   = False

'#### 회원가입 설정
CONST MEMBER_JOIN_IP    = False
CONST IP_USE = False                 ' 중복 IP 사용유무
CONST SMS_USE = False               ' SMS사용유무

CONST USER_BETGAME_CHK	= "Y"

%>
