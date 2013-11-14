require 'rspec'
load "grades.rb"
include Grades

describe StudentClass do
  let(:student) do
    ClassInputFile.all.first.student_classes.first
  end

  it 'name' do
    student.name.should == "Otilia Jones"
  end

  it 'average_grade' do
    student.average_grade.should == 76.7
  end

  it 'number of assignments' do
    student.grades.size.should == 23
  end
end

describe ClassInputFile do
  let(:file) do
    ClassInputFile.all.first
  end

  it 'students size' do
    file.student_classes.size.should == 40
  end
end

describe 'Class Files' do
  let(:list) do
    ClassInputFile.all
  end

  it 'size' do
    list.size.should == 5
  end
end

describe ClassOutputFile do
  let(:file) do
    ClassInputFile.all.first.output_file
  end

  it 'average_grade' do
    file.average_grade.should == 77.3
  end

  it 'class average row' do
    file.rows.first.should == [77.3]
  end

  it 'rows size' do
    file.rows.size.should == 41
  end

  it 'first student row' do
    file.rows[1].should == ['Otilia Jones',76.7]
  end

  it 'output_filename' do
    file.output_filename.should == "class_1_grade_averages.txt"
  end

  describe "write!" do
    before do
      file.write!
    end
    after do
      `rm classes/#{file.output_filename}`
    end

    let(:lines) do
      File.read("classes/class_1_grade_averages.txt").split("\n")
    end

    it 'basic file check' do
      lines.size.should == 41
    end

    it 'class average line' do
      lines.first.strip.should == '77.3'
    end

    it 'first student line' do
      lines[1].strip.should == 'Otilia Jones,76.7'
    end
  end
end