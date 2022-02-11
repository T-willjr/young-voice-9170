require 'rails_helper'

RSpec.describe "Professors Show Page" do
  before(:each) do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = Student.create(name: "Harry Potter" , age: 15 , house: "Gryffindor" )
    @malfoy = Student.create(name: "Draco Malfoy" , age: 10 , house: "Slytherin" )
    @longbottom = Student.create(name: "Neville Longbottom" , age: 20 , house: "Gryffindor" )

    ProfessorStudent.create(student_id: @harry.id, professor_id: @snape.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @longbottom.id, professor_id: @snape.id)
  end

  it "displays names of the students the professors have" do
    visit "/professors/#{@snape.id}"
    expect(page).to have_content(@harry.name)
    expect(page).to have_content(@longbottom.name)
    expect(page).to_not have_content(@malfoy.name)

  end

  it "displays the average age of all students for that professor" do
    visit "/professors/#{@snape.id}"
    expect(page).to have_content("Student Average Age: 17.5")
    expect(page).to_not have_content("Student Average Age: 12.5")
    visit "/professors/#{@hagarid.id}"
    expect(page).to have_content("Student Average Age: 12.5")
    expect(page).to_not have_content("Student Average Age: 17.5")
    visit "/professors/#{@lupin.id}"
    expect(page).to have_content("Student Average Age: 12.5")
    expect(page).to_not have_content("Student Average Age: 17.5")
  end
end
