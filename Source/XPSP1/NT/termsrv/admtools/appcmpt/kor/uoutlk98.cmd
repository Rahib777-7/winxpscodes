@Echo Off

Copy %SystemRoot%\System32\UsrLogn2.Cmd %SystemRoot%\System32\UsrLogn2.Bak >Nul: 2>&1
FindStr /VI Olk98Usr %SystemRoot%\System32\UsrLogn2.Bak > %SystemRoot%\System32\UsrLogn2.Cmd

Del "%SystemRoot%\System32\UsrLogn2.Bak" >NUL 2>&1

Echo Microsoft Outlook 98 로그온 스크립트 설치를 제거했습니다.

