require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "ニックネーム、メールアドレス、パスワード（確認含む）、氏名カナ、誕生日有り" do
      expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'ニックネームなし' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスなし' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレス重複' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレス、@なし' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードなし' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下' do
        @user.password = '1abc5'
        @user.password_confirmation = '1abc5'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードに全角文字を入力' do
        @user.password = '１bc４５６'
        @user.password_confirmation = '１bc４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが英字のみ' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが数字のみ' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it '再入力パスワード不一致' do
        @user.password = '123abc'
        @user.password_confirmation = '456def'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名字なし' do
        @user.second_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Second name can't be blank")
      end
      it '名前なし' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字に半角文字を入力' do
        @user.second_name = 'aｱ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Second name 全角文字を使用してください")
      end
      it '名前に半角文字を入力' do
        @user.first_name = 'bｲ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
      end
      it '名字カナなし' do
        @user.second_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Second name kana can't be blank")
      end
      it '名前カナなし' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名字カナにひらがなを入力' do
        @user.second_name_kana = 'あい'
        @user.valid?
        expect(@user.errors.full_messages).to include("Second name kana 全角カタカナを使用してください")
      end
      it '名前カナにひらがなを入力' do
        @user.first_name_kana = 'うえお'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
      end
      it '誕生日なし' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end

end
