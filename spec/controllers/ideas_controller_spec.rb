require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe "#new" do
        it "should render the new template" do
            get(:new)
            expect(response).to(render_template(:new))  
        end

        it "should set an instance variable @idea with a new Idea" do
            get(:new)
            expect(assigns(:idea)).to(be_a_new(Idea))  
        end
    end

    describe "#create" do
        context "with valid params" do

            def valid_param_request
                post(:create, params:{idea: FactoryBot.attributes_for(:idea)})
            end

            it "should create an idea in the database" do
                count_before = Idea.count
                valid_param_request
                count_after = Idea.count
                expect(count_after).to(eq(count_before + 1))  
            end
            
            it "should redirect to the show page for that idea" do
                valid_param_request
                idea = Idea.last
                expect(response).to(redirect_to idea_path(idea))  
            end
        end

        context "with invalid params" do
            def invalid_param_request
                post(:create, params:{ idea: FactoryBot.attributes_for(:idea, title: nil)})
            end

            it "should not create an idea in the database" do
                count_before = Idea.count
                invalid_param_request
                count_after = Idea.count
                expect(count_after).to(eq(count_before))  
            end

            it "should render the new page" do
                invalid_param_request
                expect(response).to(render_template(:new))  
            end
        end
    end

    describe "#show" do
        before do
            @idea = FactoryBot.create(:idea)
            get(:show, params:{id: @idea.id})
        end

        it "should render the show template" do
            expect(response).to(render_template(:show))  
        end

        it "should set an instance variable @idea for the show template" do
            expect(assigns(:idea)).to(eq(@idea))  
        end
    end

    describe "#index" do
        it "should render the index template" do
            get(:index)
            expect(response).to(render_template(:index))  
        end
        
        it "should assign an instance variable @ideas which contains all the created job posts" do
            idea_1 = FactoryBot.create(:idea)
            idea_2 = FactoryBot.create(:idea)
            idea_3 = FactoryBot.create(:idea)

            get(:index)

            expect(assigns(:ideas)).to(eq([idea_3,idea_2,idea_1]))  
        end
    end
    
    
end
