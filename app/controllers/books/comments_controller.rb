# frozen_string_literal: true

module Books
  class CommentsController < ApplicationController
    before_action :set_book
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
