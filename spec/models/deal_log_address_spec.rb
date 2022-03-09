require 'rails_helper'

RSpec.describe DealLogAddress, type: :model do  
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @deal_log_address = FactoryBot.build(:deal_log_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品が購入できる場合' do
      it 'すべての情報が入力されている' do
        expect(@deal_log_address).to be_valid
      end
      it '建物名がない場合でも購入可能' do
        @deal_log_address.building = ''
        expect(@deal_log_address).to be_valid
      end
    end

    describe '商品が購入できない場合' do
      it 'tokenなし' do
        @deal_log_address.token = nil
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号なし' do
        @deal_log_address.postcode = ''
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号に-を含まない' do
        @deal_log_address.postcode = '1234567'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '郵便番号の前3桁に不足がある' do
        @deal_log_address.postcode = '12-4567'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '郵便番号の後4桁に不足がある' do
        @deal_log_address.postcode = '123-456'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '都道府県選択せず' do
        @deal_log_address.prefecture_id = nil
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市町村なし' do
        @deal_log_address.city = ''
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地なし' do
        @deal_log_address.numbers = ''
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Numbers can't be blank")
      end
      it '電話番号なし' do
        @deal_log_address.telephone_number = ''
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号に全角数字使用' do
        @deal_log_address.telephone_number = '０９０１２３４５６７８'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Telephone number 10桁もしくは11桁の半角数字を使用してください")
      end
      it '電話番号に-記入' do
        @deal_log_address.telephone_number = '090-1234-5678'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Telephone number 10桁もしくは11桁の半角数字を使用してください")
      end
      it '電話番号10桁未満' do
        @deal_log_address.telephone_number = '090123456'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Telephone number 10桁もしくは11桁の半角数字を使用してください")
      end
      it '電話番号12桁以上' do
        @deal_log_address.telephone_number = '090123456789'
        @deal_log_address.valid?
        expect(@deal_log_address.errors.full_messages).to include("Telephone number 10桁もしくは11桁の半角数字を使用してください")
      end
    end
  end
end
