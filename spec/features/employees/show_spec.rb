require 'rails_helper'

RSpec.describe 'employee show page' do
  describe '#show' do
    it 'displays employees name and department' do
      it = Department.create!(name: "IT", floor: "Basement")
      mike = Employee.create!(name: "Mike Koul", level: 2, department_id: it.id)

      visit "/employees/#{mike.id}"

      expect(page).to have_content("Mike Koul")
      expect(page).to have_content("Department: IT")
    end

    it 'lists all of their tickets oldest to youngest' do
      it = Department.create!(name: "IT", floor: "Basement")
      mike = Employee.create!(name: "Mike Koul", level: 2, department_id: it.id)
      printer = Ticket.create!(subject: "Printer Broken", age: 2)
      computer = Ticket.create!(subject: "Computer Frozen", age: 3)
      server = Ticket.create!(subject: "Server Down", age: 1)
      EmployeeTicket.create!(employee_id: mike.id, ticket_id: printer.id)
      EmployeeTicket.create!(employee_id: mike.id, ticket_id: computer.id)
      EmployeeTicket.create!(employee_id: mike.id, ticket_id: server.id)

      visit "/employees/#{mike.id}"

      expect(page).to have_content("Computer Frozen")
      expect(page).to have_content("Printer Broken")
      expect(page).to have_content("Server Down")
    end
  end
end