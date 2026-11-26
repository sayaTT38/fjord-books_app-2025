# frozen_string_literal: true

module Reports
  class CommentsController < ApplicationController
    before_action :set_parent
    before_action :authenticate_user!

    def create
      comment = @report.comments.build(comment_params.merge(user: current_user))
      if comment.save
        redirect_to @report
      else
        redirect_to @report, alert: comment.errors.full_messages.to_sentence
      end
    end

    def destroy
      destroy_comment = current_user.comments.find(params[:id])
      destroy_comment.destroy
      redirect_to @report
    end

    private

    def set_parent
      @report = Report.find(params[:report_id])
    end

    def comment_params
      params.expect(comment: [:body])
    end
  end
end
