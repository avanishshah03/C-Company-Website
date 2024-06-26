# spec/features/platoons_integration_spec.rb

require 'rails_helper'

RSpec.describe('Platoons management', type: :feature) do
     #let!(:leader) { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: 'platoon_leader', class_year: 'fish', military_affiliation: 'Air Force', military_branch: 'USAF') }
     before do
          User.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: 'platoon_leader')
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
               provider: 'google_oauth2',
               info: {
                    email: 'john@example.com',
                    first_name: 'John',
                    last_name: 'Doe'
               }
          }
          )
          visit '/auth/google_oauth2'
     end
     describe 'Creating a new platoon' do
          it 'creates a platoon with valid attributes' do
               
               visit new_platoon_path

               fill_in 'Platoon Name:', with: 'Bravo Platoon'
               select "john@example.com", from: 'platoon[leader_id]'

               click_on 'Create Platoon'

               expect(page).to(have_content('Platoon was successfully created.'))
               expect(page).to(have_content('Bravo Platoon'))
          end

          it 'displays an error message for invalid attributes' do
               visit new_platoon_path

               # Don't fill in any fields to trigger validation errors
               click_on 'Create Platoon'

               expect(page).to(have_content("Name can't be blank"))
          end
     end

     describe 'Viewing a platoon' do
          let!(:leader) { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: 'member', class_year: 'fish', military_affiliation: 'Air Force', military_branch: 'USAF') }
          let!(:platoon) { Platoon.create(name: 'Charlie Platoon', leader_id: leader.id) }

          it 'displays the details of the platoon' do
               visit platoon_path(platoon)

               expect(page).to(have_content('Charlie Platoon'))
               expect(page).to(have_content("Leader: #{leader.first_name} #{leader.last_name}")) # Adjust as needed
          end
     end

     describe 'Editing a platoon' do
          let!(:platoon) { Platoon.create(name: 'Delta Platoon', leader_id: 1) }

          it 'updates the platoon with valid attributes' do
               visit edit_platoon_path(platoon)

               fill_in 'platoon[name]', with: 'Echo Platoon'
               select "john@example.com", from: 'platoon[leader_id]'

               click_on 'Update Platoon'

               expect(page).to(have_content('Platoon was successfully updated.'))
               expect(page).to(have_content('Echo Platoon'))
          end

          it 'displays an error message for invalid attributes' do
               visit edit_platoon_path(platoon)

               # Clearing the name field to trigger validation errors
               fill_in 'platoon[name]', with: ''

               click_on 'Update Platoon'

               expect(page).to(have_content("Name can't be blank"))
          end
     end

     # describe 'Deleting a platoon' do
     #      let!(:platoon) { Platoon.create(name: 'Foxtrot Platoon', leader_id: 1) }

     #      it 'destroys the platoon' do
     #           visit platoon_path(platoon)

     #           click_on 'Destroy this platoon'

     #           expect(page).to(have_content('Platoon was successfully destroyed.'))
     #           expect(page).to(have_no_content('Foxtrot Platoon'))
     #      end
     # end
end
