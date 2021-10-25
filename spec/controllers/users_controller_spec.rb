require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "#new => render user sign up page" do
        it "should render the new template" do
            get(:new)
            expect(response).to(render_template(:new))  
        end

        it "should set instance variable @user to a new user for the new template " do
            get(:new)
            expect(assigns(:user)).to(be_a_new(User))  
        end
    end
    
end
