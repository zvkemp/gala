# frozen_string_literal: true

class LibrariesController < ApplicationController
  before_action :set_library

  # GET /libraries/slug.json
  def show
    return head(:not_found) unless @library
  end

  private

  def set_library
    @library = Library.find_by_slug params[:slug]
    if params[:slug] == SharedCasesLibrary.instance.slug
      @library ||= SharedCasesLibrary.instance
    end
  end
end
