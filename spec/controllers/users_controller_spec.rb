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

    describe "#create" do
        context "valid params" do
            def valid_request
                post(:create, params: {user: FactoryBot.attributes_for(:user)})
            end

            it "should create a user in the db" do
                count_before = User.count
                valid_request
                count_after = User.count
                expect(count_after).to(eq(count_before + 1))  
            end

            it "should redirect to the ideas index page" do
                valid_request
                expect(response).to(redirect_to(ideas_path))  
            end

            it "should set a flash message" do
                valid_request
                expect(flash[:success]).to(be)  
            end
            
        end

        context "invalid params" do
            def valid_request
                post(:create, params: {user: FactoryBot.attributes_for(:user, password: nil)})
            end

            it "should not create a user in the db" do
                count_before = User.count
                valid_request
                count_after = User.count
                expect(count_after).to(eq(count_before))  
            end

            it "should redirect to the ideas index page" do
                valid_request
                expect(response).to(render_template(:new))  
            end
        end
        
        
    end
    
    
end
