require "rails_helper"

describe FlowersController do 

  describe "Admin actions" do
    let(:session) {FactoryGirl.create(:session)}
    let(:user) {FactoryGirl.create(:user_admin, session: session)}

    it "redirects anonymous to login page" do
      post :create, {type_id: 3, flower: {name: "rose"}}

      expect(response).to redirect_to "/login"
    end

    it "returns OK for admin users" do
      cookies[:token] = user.session.token
      post :create, {type_id: 3, flower: {name: "rose"}}

      expect(response).not_to redirect_to "/login"
      expect(response.code).to eq "200"
    end
  end

  describe "Create Flower" do
    let(:flower) {FactoryGirl.create(:flower)}

    it "returns OK for admin users" do
      expect(response.code).to eq "200"
    end
  end

end