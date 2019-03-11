class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  def after_sign_up_path_for(resource)
    user_path(resource.id)
  end

  helper_method :guest_user?, :current_or_guest_user
  include AlbumsHelper

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


  def current_or_guest_user
    if current_user
      if session[:guest_user] && session[:guest_user] != current_user.id
        logging_in
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # 現在のセッションと関連づくguest_user オブジェクトを探す
  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  #ActiveRecord::RecordNotFoundエラーが起きた時（session[:guest_user_id]が無効だった時）
  rescue ActiveRecord::RecordNotFound
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  def logging_in
    guest_user.move_to(current_user)
  end

  def create_guest_user
    u = User.new(name: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@example.com" )
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end

end
