class LessonsController < ApplicationController
	before_action :require_enrollment_for_viewing_lessons
	def show
	end

	private
	
	def require_enrollment_for_viewing_lessons
		if !current_user.enrolled_in?(current_lesson.section.course)
			redirect_to course_path(current_lesson.section.course), :alert => 'Please enroll'
		end
	end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end
end
