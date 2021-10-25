require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe "#new => render user sign in page" do
        it "should render the new template" do
            get(:new)
            expect(response).to(render_template(:new))  
        end
    end
    
end
