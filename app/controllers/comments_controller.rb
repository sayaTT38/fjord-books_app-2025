# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parent, only: %i[create destroy]
  before_action :authenticate_user!, only: %i[ create destroy ]

  def create
    comment =@parent.comments.build(comment_params.merge(user: current_user))
    if comment.save
      redirect_to @parent
    else
      redirect_to @parent, alert: comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    destroy_comment = @parent.comments.find(params[:id])
    if destroy_comment.user == current_user
      destroy_comment.destroy
      redirect_to @parent
    else
      redirect_to @parent, alert: 'コメントを削除する権限がありません'
    end
  end

  private
    def set_parent
    if params[:book_id]
      @parent = Book.find(params[:book_id])
    elsif params[:report_id]
      @parent = Report.find(params[:report_id])
    end

    end
    def comment_params
      params.expect(comment: [ :body ])
    end

end
