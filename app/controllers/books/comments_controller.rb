# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    before_action :set_parent
    before_action :authenticate_user!

    def create
      comment = @book.comments.build(comment_params.merge(user: current_user))
      if comment.save
        redirect_to @book
      else
        redirect_to @book, alert: comment.errors.full_messages.to_sentence
      end
    end

    def destroy
      destroy_comment = @book.comments.find(params[:id])
      if destroy_comment.user == current_user
        destroy_comment.destroy
        redirect_to @book
      else
        redirect_to @book, alert: 'コメントを削除する権限がありません'
      end
    end

    private

    def set_parent
      @book = Book.find(params[:book_id])
    end

    def comment_params
      params.expect(comment: [:body])
    end
  end
end
