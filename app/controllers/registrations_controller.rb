class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  layout "auth"
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_registration_path, alert: "Demasiados intentos. Inténtalo más tarde." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.lists.create!(name: "Mi primera lista", icon: "🎯", color: "indigo")
      start_new_session_for @user
      redirect_to root_path, notice: "¡Bienvenido, #{@user.first_name}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.expect(user: %i[ name email_address password password_confirmation ])
    end
end
