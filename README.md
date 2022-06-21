# NPTUFOA
2022 ios lesson project
屏大民生校區 線上點餐整合服務APP

公開版本 屏東大學110-2學年度 iOS程式設計 之 Final Project

# 組員：
CBE109042 陳歆宜
CBE109047 洪雪華
CBE109048 徐采碟

# 專案概述：
專案發想是來自晉來坐簡餐的便當預定群組，我們認為這樣可以很好的讓店家知道同學喜歡什麼樣的菜色，同學也可以方便訂餐領餐。
疫情爆發加上學餐人擠人的情況下，希望可以打造一個線上點餐系統，來透過和學餐店家合作，讓店家檢閱以及修改線上試算表確認是否做餐以及領餐，再經由學生準時去領餐之行為，讓學餐內不再擁擠的水洩不通。
防疫有保障，胃也有飽脹。

# 專案目的
減少學餐區域人群聚集之可能性，讓學生在一個APP裡可以點到各種商家的餐點，商家也可以在一個試算表裡面整理出還未做餐的訂單，統計學生愛吃的餐點去做宣傳或促銷。

# 專案重要性
疫情爆發之下發想出來的專案，是時下所需，且因為目前屏大APP沒有附屬這種功能，我們認為這樣的APP是一個度過疫情高峰期適用，且可以延續至疫情降溫後持續使用的專案產品。

# APP架構：
1.登入介面→登入成功→彈出表單開始點餐→確認點餐內容返回流水號頁面→刷新/顯示流水號→返回登入介面
2.登入介面→登入成功→彈出表單但不點餐→返回流水號頁面→刷新/顯示流水號→返回登入介面
3.登入介面→彈出登入失敗警示視窗→OK→回到登入介面

# 商家後臺架構：
1.Excel : 商家表

#功能介紹及使用方式 (畫面呈現的方式以及所使用到的相關技術)

> APP 表面看到的功能介紹 

## 學生登記系統
使本機紀錄的字串可以對資料庫(google sheet)進行互動，確認學生是否正常登入。
## 點餐系統
利用低程式碼平台發送表單請求，將使用者訂的餐點以及想下訂單的時間正確的發到資料庫(google sheet)中。
## 流水編號取餐
透過API產生的json檔，交互確認最新一筆訂單內容，將記錄好的流水編號抓回來至學生的APP端，顯示流水編號。

> APP 背地運作之功能介紹 

## 資料庫 [Google Sheets]
[Google Sheets]:(https://www.google.com.tw/intl/zh-TW/sheets/about/)
商家能看見其資料庫內容，並使用表格篩選功能選擇自家店家，確認尚未製作的訂單。

## 低程式碼平台實作部分API功能 [SheetDB]
[SheetDB]:(https://sheetdb.io/)
利用其表單製作之功能，來做到可以自動將使用者填寫好的資料回傳至資料庫。
API中UPDATE的實作交給其平台。

## 腳本部屬作業實作部分API功能 [Google Apps Script]
[Google Apps Script]:(https://developers.google.com/apps-script)
配合Google試算表之使用，利用部屬作業來產生json檔案，方便swift端讀取。
API中GET的實作交給其平台。

# 預期工作項目與未來展望 

## 已完成功能 
UI版面設計。 
Auto Layout。 
Alert畫面。 
點餐頁面。 
流水號顯示頁面。 
商家閱覽版面。 
API。 
線上同步資料庫。 
走訪JSON。 

## 未來展望
更完善的登入系統。 
健康偵測系統。 
卡路里系統。 
營養內容顯示。 
成就系統（Ex：累計點餐的次數、連續五天吃咖哩飯加大、連續五天吃玉米蛋餅）。 

# 成果Demo影片

## 影片本身
https://www.youtube.com/watch?v=j6sZV2iWZyQ

## 使用概述
正常使用會分為兩種狀況

1. 預定餐點 (沒有馬上領餐)
  (步驟1). 輸入學號登入，點餐確認餐點訂單成功送出，按返回回到流水編號頁面，離開APP。
  (步驟2). 領餐時間打開APP，輸入學號登入，離開點餐表單，點擊左下角按鈕重新整理號碼。
  (步驟3). 拿著號碼去領餐。
  
2. 訂購餐點 (選擇馬上領餐)
  (步驟1). 輸入學號登入，點餐確認餐點訂單成功送出，點擊左下角按鈕重新整理號碼。
  (步驟2). 拿著號碼去領餐。

## 疑難排解

1. 無法登入
> 學號輸入欄留空則無法登入。 
2. 序號沒有正常顯示
> 資料庫沒有此筆資料，會維持⍩符號。正常點餐後刷新會拿到新的流水號。

# 專案結論
結論
我們認為我們有順利地做出當初預期的畫面以及成果，運用到整學期所學之知識，以及我們小組再去自行爬文，做出應用幾個不一樣平台的程式作品。

在這之前除了老師的帶領之下，我們兩個都沒有實作過需要GET/UPDATE指令的APP，其實也不太懂API到底是什麼意思，也沒有實作過抓取json檔案的部分。
沒想到第一次去做就是在寫swift，非常不熟悉的語言。
感覺這次的專案比較像是學習如何和不一樣的平台做互動，無論是把試算表當作資料庫、利用low code平台去做UPDATE資料庫、利用GAS(GoogleApp Script)去做GETRequest，都是我們沒有接觸過，從零開始的新學習。
雖然覺得在介面上，美術細胞不夠好的我們只能做出簡潔風格，但功能單純的程式，也花了我們2、3個禮拜常常來借iOS教室才順利完成。

若是說有想要精進的地方，或許是把商業頁面做得更好看一些，但我想那就會考慮到資料庫READ、GET等等問題，會需要更熟識網路部分。也或許是把APP介面做的更好看一些，這邊則是要好好學習設計頁面的問題。
