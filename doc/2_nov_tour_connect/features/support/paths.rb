module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the sign up page/
      '/users/sign_up'

    when /the sign in page/
      '/users/sign_in'

    when /the edit admin "(.*)" accommodation page/
      accommodation = Accommodation.where(:name => $1).first
      edit_admin_accommodation_path(accommodation)

    when /"(.*)" step of the edit admin "(.*)" accommodation page/
      accommodation = Accommodation.where(:name => $2).first
      edit_admin_accommodation_path(accommodation, :step => $1)

    when /the edit admin "(.*)" non accommodation page/
      non_accommodation = NonAccommodation.where(:name => $1).first
      edit_admin_non_accommodation_path(non_accommodation)

    when /"(.*)" step of the edit admin "(.*)" non accommodation page/
      non_accommodation = NonAccommodation.where(:name => $2).first
      edit_admin_non_accommodation_path(non_accommodation, :step => $1)

    when /the edit admin accommodation "(.*)" product page/
      accommodation_product = AccommodationProduct.where(:name => $1).first
      edit_admin_accommodation_product_path(accommodation_product)

    when /"(.*)" step of the edit admin accommodation "(.*)" product page/
      accommodation_product = AccommodationProduct.where(:name => $2).first
      edit_admin_accommodation_product_path(accommodation_product, :step => $1)

    when /the edit admin non accommodation "(.*)" product page/
      non_accommodation_product = NonAccommodationProduct.where(:name => $1).first
      edit_admin_non_accommodation_product_path(non_accommodation_product)

    when /"(.*)" step of the edit admin non accommodation "(.*)" product page/
      non_accommodation_product = NonAccommodationProduct.where(:name => $2).first
      edit_admin_non_accommodation_product_path(non_accommodation_product, :step => $1)

    when /the edit admin signup page/
      '/admin/signup/edit'

    # when /the edit admin billing information page/
    #   '/admin/billing_information/edit'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
