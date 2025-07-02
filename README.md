# BalanceChecker

## 概要
BalanceCheckerは、パーソナルデータと食品情報をもとに、約2500種類の食品データから1日に必要な栄養素の充足率をリアルタイムで可視化するWebアプリケーションです。
Vue.jsを使ったシングルページアプリ（SPA）として設計されており、簡単に食品検索・登録・栄養素計算が可能です。

## 開発背景
栄養管理をする際、  
「消費カロリー計算サイト」や「性別・年齢別の摂取推奨量掲載サイト」、  
「栄養素別の食品ランキングサイト」など複数のWebサイトを行き来する必要がありました。  
そこで、これらの機能を一つに統合し、  一つのページで完結できるWebアプリを作成しました。


## 主な機能
- 年齢・性別・身体活動レベルなどのパーソナルデータ入力  
- 食品名のインクリメンタルサーチ（リアルタイム検索）  
- 選択食品の一覧表示と栄養素の合計値計算  
- 栄養素充足率のパーセント表示およびグラフ可視化

## 使用技術
- フロントエンド：Vue.js（CDN版）、Vuetify （CDN版）、ECharts（CDN版）
- バックエンド：Java Servlet
- 開発環境：Visual Studio Code、Eclipse

## スクリーンショット
### トップ画面  
![トップ画面](./screenshots/top.PNG)

### 食品名検索画面  
![食品名検索画面](./screenshots/search1.PNG)

### 栄養素別検索画面  
![栄養素別検索画面](./screenshots/search2.PNG)

## 今後の改善点
- 食品別詳細表示
- モバイル対応のUI強化  
- おすすめ食品提案機能の実装

- ## データソース・参考文献
- 食品成分データ：  
　「本食品標準成分表（八訂）増補2023年」  
　出典：文部科学省
　[https://www.mext.go.jp/a_menu/syokuhinseibun/mext_00001.html](https://www.mext.go.jp/a_menu/syokuhinseibun/mext_00001.html)

- 栄養素の推奨摂取量：  
　「日本人の食事摂取基準（2025年版）」策定検討会報告書
　出典：厚生労働省  
　[https://www.mhlw.go.jp/stf/newpage_08517.html](https://www.mhlw.go.jp/stf/newpage_44138.html)
