require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "Display Taks" do
	  	Post.create!(title:"Post one")	# Model Method
      visit posts_path # Capybara methods : visit 
      page.should have_content("Post one")  # Capybara methods : page.shoud have_content
    end

    it "supports js", :js => true do
      visit posts_path # Capybara methods : visit 
      click_link "test js" # Capybara methods : click_link
      page.should have_content("js works") # Capybara methods : page.shoud have_content
    end
  end

  describe "PUT /posts" do
  	it "updte post" do
  		p= Post.create!(title: "Post one")	#Model Method
  		visit posts_path # Capybara methods : visit
  		visit edit_post_path(p) # Capybara methods : visit route with object
  		fill_in 'Title', :with => 'New post' # Capybara methods : fill_in 
  		click_button('Update Post') # Capybara methods : click_button
  		page.should have_content("Post was successfully updated") # Capybara methods : page.shoud have_content
  	end
	end

  describe "POST /posts" do
    it "Create Taks" do
	  	Post.create!(title: "Post one")	# Model Method
      post_via_redirect posts_path ,post: {title:"no one"} # Capybara methods : post_via_redirect 
      page.should have_content("Post was successfully created") # Capybara methods : page.shoud have_content
    end
  end
end
