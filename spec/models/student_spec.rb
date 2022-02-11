require 'rails_helper'

RSpec.describe Student, type: :model do

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :house}
  end

  describe 'relationships' do
    it {should have_many :professor_students}
    it {should have_many(:professors).through(:professor_students)}
  end

  describe "average_age" do
    it "returns average age" do
      harry = Student.create(name: "Harry Potter" , age: 10 , house: "Gryffindor" )
      malfoy = Student.create(name: "Draco Malfoy" , age: 10 , house: "Slytherin" )
      longbottom = Student.create(name: "Neville Longbottom" , age: 10 , house: "Gryffindor" )

      expect(Student.average_age).to eq(10)
    end
  end
end
