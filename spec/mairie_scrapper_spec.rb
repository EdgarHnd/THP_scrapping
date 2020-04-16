require_relative '../lib/mairie_scrapper'

describe "the scrapping mairie app" do
    it "should not return an empty name array" do
        expect(scrapping_mairie_name).not_to be_nil
    end
    it "should not return an empty email array" do
        expect(scrapping_mairie_email).not_to be_nil
    end
    it "should return a final array of size 185" do
        a = scrapping_mairie_name
        b = scrapping_mairie_email
        expect(final_mairie_array(a,b).size).to eq(185)
    end
end