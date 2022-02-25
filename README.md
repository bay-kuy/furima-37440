# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル

| Column             | Type    | Options                    |
| ------------------ | ------- | -------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| first_name         | string   | null: false               |
| second_name        | string   | null: false               |
| first_name_kana    | string   | null: false               |
| second_name_kana   | string   | null: false               |
| birthday           | datetime | null: false               |

### Association

- has_many :items
- has_many :deal_logs
- has_one :address


### items テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| name                 | string     | null: false                    |
| description          | text       | null: false                    |
| user                 | references | null: false, foreign_key: true |
| category_id          | integer    | null: false                    |
| condition_id         | integer    | null: false                    |
| postage_id           | integer    | null: false                    |
| prefecture_id        | integer    | null: false                    |
| ship_date_id         | integer    | null: false                    |
| price                | integer    | null: false                    |


### Association

- belongs_to :user
- has_one :deal_log


### deal_logs テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| item    | references | null: false, foreign_key: true |
| user    | references | null: false, foreign_key: true |
| address | references | null: false, foreign_key: true |

### Association

- has_one :items
- belongs_to :user
- has_one :address


### addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postcode         | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| numbers          | string     | null: false                    |
| building         | string     |                                |
| telephone_number | string     | null: false                    |


### Association

- has_one :deal_log