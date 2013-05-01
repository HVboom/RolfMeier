require 'spec_helper'

describe DeploymentController do

  describe "GET 'deploy'" do
    it "returns http success" do
      get 'deploy'
      response.should be_success
    end
  end

end
