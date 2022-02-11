require 'rails_helper'

RSpec.describe "Students Show Page" do
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

  it "displays a list of students and the number of professors each student has" do
    visit "/students"
    expect(page).to have_content("Harry Potter: 3")
    expect(page).to have_content("Draco Malfoy: 2")
    expect(page).to have_content("Neville Longbottom: 1")
    expect(page).to_not have_content("Severus Snape")
    expect(page).to_not have_content("Rubeus Hagrid")
  end

  it "displays students in alphabetical order" do
    visit "/students"
    expect(@malfoy.name).to appear_before(@harry.name)
    expect(@malfoy.name).to appear_before(@longbottom.name)
    expect(@harry.name).to appear_before(@longbottom.name)
    expect(@longbottom.name).to_not appear_before(@harry.name)
  end
end
