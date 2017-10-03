class Users::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: [:destroy, :create]
  before_action :check_user_has_flash, only: :create
  before_action :check_user_has_flash, :if => sign_in_params.empty?, only: :new

  layout :user_layout

  def new
    self.resource = resource_class.new(sign_in_params)
    puts "sign_in_paramsxxx"
    puts sign_in_params
    # byebug
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  protected
  def user_layout
    "users/layouts/application"
  end
end
