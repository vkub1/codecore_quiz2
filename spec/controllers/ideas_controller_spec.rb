require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    context "as signed in user" do
        before do
            @user = FactoryBot.create(:user)
            session[:user_id] = @user.id
        end
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
        
        describe "#destroy" do
            context "as owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @idea = FactoryBot.create(:idea, user: current_user)
                    delete(:destroy, params:{ id:@idea.id})
                end
        
                it "should remove a job post from the database" do
                    expect(Idea.find_by(id: @idea.id)).to(be(nil)) 
                end
        
                it "should redirect to the ideas index" do
                    expect(response).to(redirect_to(ideas_path)) 
                end
        
                it "should set a flash message" do
                    expect(flash[:alert]).to be
                end
            end
            
            context "as non owner" do
                before do
                    session[:user_id] = FactoryBot.create(:user).id
                    @idea = FactoryBot.create(:idea)
                    delete(:destroy, params:{id:@idea.id})
                end
                
                it "idea should not be removed from db" do
                    expect(Idea.find(@idea.id)).to(eq(@idea)) 
                end

                it "should redirect to the show page" do
                    expect(response).to(redirect_to(idea_path(@idea))) 
                end
            end
        end
    
        describe "#edit" do
            context "as owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @idea = FactoryBot.create(:idea, user: current_user)
                    get(:edit, params:{id: @idea.id})
                end
        
                it "should render the edit template" do
                    expect(response).to(render_template(:edit)) 
                end
        
                it "should set the instance variable @idea for the edit template" do
                    expect(assigns(:idea)).to(eq(@idea)) 
                end
            end

            context "as non owner" do
                it "should redirect to show page" do
                    session[:user_id] = FactoryBot.create(:user).id
                    idea = FactoryBot.create(:idea)
                    get(:edit, params:{id: idea.id})
                    expect(response).to(redirect_to(idea_path(idea.id))) 
                end
            end
            
            
            
        end
    
        describe "#update" do
            context "as owner" do
                before do
                    current_user = FactoryBot.create(:user)
                    session[:user_id] = current_user.id
                    @idea = FactoryBot.create(:idea, user: current_user)
                end
                context "with valid params" do
                    before do
                        @new_title = "#{@idea.title} plus something"
                        patch(:update, params:{id: @idea.id, idea:{title:@new_title} })
                    end
        
                    it "should update the idea in the database" do
                        expect(@idea.reload.title).to(eq(@new_title))
                    end
        
                    it "should redirect to the show page" do
                        expect(response).to(redirect_to idea_path(@idea))  
                    end
                    
                end
                
                context "with invalid params" do
                    before do
                        patch(:update, params:{id: @idea.id, idea:{title:nil} })
                    end
        
                    it "should not update the idea record" do   
                        expect(@idea.reload.title).to(eq(@idea.title)) 
                    end
        
                    it "should render the edit template" do
                        expect(response).to(render_template(:edit))  
                    end
        
                    it "should set instance variable @idea for edit template" do
                        expect(assigns(:idea)).to(eq(@idea))  
                    end
                    
                end
            end
            
            context "as non owner" do
                before do
                    session[:user_id] = FactoryBot.create(:user).id
                    @idea = FactoryBot.create(:idea)
                    @new_title = "#{@idea.title} plus something"
                    patch(:update, params:{id: @idea.id, idea:{title:@new_title} })
                end

                it "idea should not be updated in the db" do
                    expect(Idea.find(@idea.id)).to(eq(@idea)) 
                end

                it "should redirect to the show page" do
                    expect(response).to(redirect_to(idea_path(@idea))) 
                end


                
            end
            
            
        end
    end

    context "as signed out user" do
        describe "#new" do
            it "should redirect to the sign in page" do
                get(:new)
                expect(response).to(redirect_to(new_session_path))  
            end
        end

        describe "#create" do
            it "should redirect to the sign in page" do
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
                expect(response).to(redirect_to(new_session_path))  
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

        describe "#destroy" do
            it "should redirect to the sign in page" do
                idea = FactoryBot.create(:idea)
                delete(:destroy, params:{ id:idea.id})
                expect(response).to(redirect_to(new_session_path))  
            end
        end

        describe "#edit" do
            it "should redirect to the sign in page" do
                @idea = FactoryBot.create(:idea)
                get(:edit, params:{id: @idea.id})
                expect(response).to(redirect_to(new_session_path))  
            end
        end

        describe "#update" do
            it "should redirect to the sign in page" do
                @idea = FactoryBot.create(:idea)
                @new_title = "#{@idea.title} plus something"
                patch(:update, params:{id: @idea.id, idea:{title:@new_title}})
                expect(response).to(redirect_to(new_session_path))  
            end
        end
    end
end
