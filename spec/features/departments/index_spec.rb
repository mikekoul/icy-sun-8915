require 'rails_helper'

RSpec.describe 'department index page' do
  describe '#index' do
    it 'list of all departments and the floor they are located' do
      it = Department.create!(name: "IT", floor: "Basement")
      ad = Department.create!(name: "Advertising", floor: "1st floor")
      finance = Department.create!(name: "Finance", floor: "2nd floor")

      visit '/departments'

      expect(page).to have_content("Name: IT, Location: Basement")
      expect(page).to have_content("Name: Advertising, Location: 1st floor")
      expect(page).to have_content("Name: Finance, Location: 2nd floor")
    end

    xit 'underneath each department I see the name its employees' do
      it = Department.create!(name: "IT", floor: "Basement")
      ad = Department.create!(name: "Advertising", floor: "1st floor")
      finance = Department.create!(name: "Finance", floor: "2nd floor")
      mike = Employee.create!(name: "Mike Koul", level: 2, department_id: it.id)
      cindy = Employee.create!(name: "Cindy Lou", level: 3, department_id: ad.id)
      david = Employee.create!(name: "David Creed", level: 1, department_id: finance.id)


      visit '/departments'

      within "#departments-#{it.id}" do
        expect(page).to have_content("Mike Koul")
        expect(page).to_not have_content("Cindy Lou")
      end

      within "#departments-#{ad.id}" do
        expect(page).to have_content("Cindy Lou")
        expect(page).to_not have_content("David Creed")
      end

      within "#departments-#{finance.id}" do
        expect(page).to have_content("David Creed")
        expect(page).to_not have_content("Mike Koul")
      end

    end
  end
end