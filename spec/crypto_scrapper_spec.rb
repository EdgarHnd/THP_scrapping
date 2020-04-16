require_relative '../lib/crypto_scrapper'

describe "the scrapping crypto app" do
    it "should not return an empty name array" do
        expect(scrapping_name).not_to be_nil
    end
    it "should not return an empty price array" do
        expect(scrapping_price).not_to be_nil
    end
    it "should return a final array of size 200" do
        a = scrapping_name
        b = scrapping_price
        clean_price(b)
        expect(final_array(a,b).size).to eq(200)
    end
    it "should have BTC value in the final array" do
        a = scrapping_name
        b = scrapping_price
        clean_price(b)
        expect(final_array(a,b)[0].include?("BTC")).to eq(true)
    end
end