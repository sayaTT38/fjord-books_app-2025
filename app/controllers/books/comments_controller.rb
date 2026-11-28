# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    before_action :set_book

    def create
      comment = @book.comments.build(comment_params)
      comment.user = current_user
      comment.save!
      redirect_to @book
    end

    def destroy
      comment = current_user.comments.find(params[:id])
      comment.destroy
      redirect_to @book
    end

    private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def comment_params
      params.expect(comment: [:body])
    end
  end
end
