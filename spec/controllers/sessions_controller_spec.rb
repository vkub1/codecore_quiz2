require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe "#new => render user sign in page" do
        it "should render the new template" do
            get(:new)
            expect(response).to(render_template(:new))  
        end
    end

    describe "#create" do
        before do
            @user = FactoryBot.create(:user)
        end
        
        context "with valid params" do
            before do
                post(:create, params: {email: @user.email, password: @user.password})
            end

            it "should redirect to the ideas index page" do
                expect(response).to(redirect_to(ideas_path))  
            end
            
            it "should set a flash success message" do
                expect(flash[:success]).to(be)  
            end
            
        end
        
        context "with invalid params" do
            before do
                post(:create, params: {email: @user.email, password: nil})
            end

            it "should render the new template" do
                expect(response).to(render_template(:new))  
            end

            it "should render set a flash alert message" do
                expect(flash[:alert]).to(be)
            end
        end
    end

    
    
    
    
    
end
