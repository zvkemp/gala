# frozen_string_literal: true

# @see Enrollment
class EnrollmentsController < ApplicationController
  before_action :authenticate_reader!
  before_action :set_enrollment, only: %i[create destroy]

  # @route [GET] `/enrollments`
  def index
    @enrollments = current_reader.enrollments

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json
    end
  end

  # @route [POST] `/cases/case-slug/enrollment`
  def create
    authorize @enrollment

    if @enrollment.save
      head :created
    else
      head :unprocessable_entity
    end
  end

  # @route [DELETE] `/cases/case-slug/enrollment`
  def destroy
    head :no_content && return unless @enrollment

    authorize @enrollment
    @enrollment.destroy
  end

  private

  def set_enrollment
    kase = Case.friendly.find params[:case_slug]
    @enrollment = Enrollment.find_or_initialize_by case_id: kase.id,
                                                   reader_id: current_reader.id
  end
end
