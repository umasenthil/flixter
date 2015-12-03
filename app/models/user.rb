class User < ActiveRecord::Base
	has_many :courses
	has_many :enrollments
	# the below line does the same thing as this line. has_many through is like a macro for this enrolled_courses = enrollments.collect(&:course)
	# If we have done enrollments do each |enrollment| enrolled_courses << enrollment.course we have make one call to get all the enrollments 
	# and make n calls to get course. By doing either of the above we are reducing N calls to database
	has_many :enrolled_courses, :through => :enrollments, :source => :course
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def enrolled_in?(course)
      return enrolled_courses.include?(course)
  end
end
