# frozen_string_literal: true

module Reports
  class CommentsController < ApplicationController
    before_action :set_report
    before_action :authenticate_user!

    def create
      comment = @report.comments.build(comment_params)
      comment.user = current_user
      comment.save!
      redirect_to @report
    end

    def destroy
      comment = current_user.comments.find(params[:id])
      comment.destroy
      redirect_to @report
    end

    private

    def set_report
      @report = Report.find(params[:report_id])
    end

    def comment_params
      params.expect(comment: [:body])
    end
  end
end
