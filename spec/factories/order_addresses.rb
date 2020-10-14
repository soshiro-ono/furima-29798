FactoryBot.define do
  factory :order_address do
    postal_code       {"123-1234"}
    prefectures_id    {4}
    municipality      {"兵庫区"}
    address           {"河原１丁目"}
    phone             {"09087654321"}
    token             {"tok_abcdefghijk00000000000000000"}
  end
end
