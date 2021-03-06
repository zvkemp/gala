# frozen_string_literal: true

module Readers
  # Handles signing in and signing out
  class SessionsController < Devise::SessionsController
    include MagicLink
    # before_action :configure_sign_in_params, only: [:create]

    respond_to :html, :json, '*/*'

    # @method new
    # @route [GET] `/resource/sign_in`
    # ```
    # def new
    #   super
    # end
    # ```

    # @route [POST] `/resource/sign_in`
    def create
      super do
        link_reader if following_magic_link?
      end
    end

    # @method destroy
    # @route [DELETE] `/resource/sign_out`
    # ```
    # def destroy
    #   super
    # end
    # ```

    protected

    def after_sign_in_path_for(_resource)
      after_linking_redirect_path || stored_location_for(:user) || root_path
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
