class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_global_layout, only: :edit

  layout :user_layout

  def destroy  
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)  
    set_flash_message :notice, :destroyed if is_flashing_format?  
    yield resource if block_given?  
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }  
  end 

  protected
  def user_layout
    "users/layouts/application"
  end

  def set_global_layout
    @is_global_layout = true
  end
end
