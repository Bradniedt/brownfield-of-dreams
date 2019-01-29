require 'rails_helper'

describe 'As a default user' do
  describe 'when I log in' do
    it 'my dashboard should have a github section with repo names as links' do
      VCR.use_cassette("github_service") do
        user = create(:user, token: "hello")
        visit '/'

        click_on "Sign In"
        expect(current_path).to eq(login_path)

        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_css(".repo", count: 5)

        within(".github") do
          expect(page).to have_link("little-shop")
        end
      end
    end
    it 'my dashboard should NOT have a github section with repo names as links' do
      user = create(:user)
      visit '/'

      click_on "Sign In"
      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_css(".github")
    end
  end
end
