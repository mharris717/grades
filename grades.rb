require 'csv'
require 'mharris_ext'

class Array
  def average
    inject { |s,i| s + i }.to_f / size.to_f
  end
end

module Grades
  class ClassInputFile
    include FromHash
    attr_accessor :path

    fattr(:student_classes) do
      res = []
      CSV.foreach(path) do |row|
        grades = row[1..-1].map { |x| x.to_i }
        res << StudentClass.new(:name => row[0], :grades => grades)
      end
      res
    end

    def output_file
      ClassOutputFile.new(:student_classes => student_classes, :input_filename => File.basename(path))
    end

    def write!
      output_file.write!
    end

    class << self
      fattr(:all) do
        Dir["classes/*.csv"].map { |x| new(:path => x) }
      end
    end
  end

  class StudentClass
    include FromHash
    attr_accessor :name, :grades

    def grades=(gs)
      raise "bad grades" if gs.any? { |x| x > 100 || x < 0 }
      @grades = gs
    end

    def average_grade
      grades.average.round(1)
    end
  end

  class ClassOutputFile
    include FromHash
    attr_accessor :student_classes, :input_filename
    def average_grade
      student_classes.map { |x| x.average_grade }.average.round(1)
    end

    def rows
      res = []
      res << [average_grade]
      res += student_classes.map do |student|
        [student.name,student.average_grade]
      end
      res
    end

    def output_filename
      input_filename.gsub("grades.csv","grade_averages.txt")
    end

    def write!
      CSV.open("classes/#{output_filename}","w") do |csv|
        rows.each do |row|
          csv << row
        end
      end
    end
  end

  def self.run!
    ClassInputFile.all.each { |x| x.write! }
  end
end

