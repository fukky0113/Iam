# README

# ポートフォリオ
私の自己紹介サイトです。
Ruby on RailsやAWSを用いた開発の実験ラボも兼ねています。

# 機能一覧
|ホーム画面|ログイン画面|
|---|---|
|ホーム画面。|ログインIDとパスワードからログイン処理。自動ログイン機能処理を実装。|
|![alt text](pic/ホーム.png)|![alt text](pic/ログイン.png)|

|ポスト一覧|ポスト投稿|
|---|---|
|カテゴリごとにポストが表示。editとdeleteは管理者権限を持つユーザーのみに表示。|リッチテキストエディタを実装(写真の投稿も可)。カテゴリの追加のハイパーリンクからカテゴリの追加が可能。|
|![alt text](pic/ポスト一覧.png)|![alt text](pic/ポスト投稿.png)|

|ポスト詳細|ポスト編集|
|---|---|
|カテゴリ、タイトル、本文の表示。|管理者のみポストの編集が可能。|
![alt text](pic/ポスト詳細.png)|![alt text](pic/ポスト編集.png)|

|ユーザー一覧|ユーザー詳細|
|---|---|
|管理者のみアクセス可。それぞれのハイパーリンクから処理が可。||
|![alt text](pic/ユーザー一覧.png)|![alt text](pic/ユーザー詳細.png)|

|ユーザー追加|ユーザー詳細|
|---|---|
|![alt text](pic/ユーザー新規.png)|![alt text](pic/ユーザー編集.png)|

他各種設定画面(プロフィール、スキル、プロジェクト経歴 ...etc)

# 使用技術
|Category|Technology Stack|
|---|---|
|Frontend|Bootstrap(v5.3.3)|
|Backend|Ruby(v3.2.1), RubyonRails(v7.0.8.7), Puma(v5.6.9), Nginx(v1.26)|
|Infrastructure|AWS(後述)|
|Database|Postgres(v16.3)|
|Environment setup|Docker(v27.3.1)|
|CI/CD|GithubActions|

# 構成図
![alt text](pic/構成図.png)

# 機能一覧
 - ログイン(自動ログイン機能)/ログアウト
 - ポスト投稿機能(リッチテキスト)
 - ユーザー管理機能
 - 個人の基本情報を登録(プロフィール、スキル、プロジェクト)

# ER図
![alt text](pic/ER図.png)
