Then /^the invitation "([^\"]*)" should have the following values:$/ do |invitation_email, table|
  invitation = Invitation.where(:email => invitation_email).first

  table.hashes.each do |hash|
    invitation.email.should      == hash['email']
    invitation.first_name.should == hash['first_name']
    invitation.last_name.should  == hash['last_name']
  end
end

Given /^the following invitations:$/ do |table|
  table.hashes.each do |hash|
    Factory.create(:invitation, hash)
  end
end

Given /^the following invitations by "([^\"]*)":$/ do |email, table|
  user = User.where(:email => email).first

  table.hashes.each do |hash|
    invitation = Factory.build(:invitation, hash.merge(:user => user))
    invitation.save(:validate => false)
  end
end

When /^the invitation mail process is run$/ do
  Invitation.deliver_unsent_invitations
end

Then /^invitations should have the following values:$/ do |table|
  table.hashes.each do |hash|
    invitation = Invitation.where(:company_name => hash['company_name'], :email => hash['email']).first
    invitation.first_name.should == hash['first_name']
    invitation.last_name.should  == hash['last_name']
  end
end

Then /^the attachment should contain:$/ do |table|
  csv = CSV.parse(current_email_attachments.first.read)

  found = {}
  table.hashes.each do |hash|
    found[hash['company_name']] = false

    csv.each do |row|
      if row[0] == hash['company_name']
        row[1].should == hash['email']
        row[2].should == hash['first_name']
        row[3].should == hash['last_name']
        row[4].should == hash['status']

        found[hash['company_name']] = true
      end
    end
  end

  found.each {|k,v| v.should be_true }
end
