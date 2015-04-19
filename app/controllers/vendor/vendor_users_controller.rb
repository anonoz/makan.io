class Vendor::VendorUsersController < Vendor::MainController
  before_action :set_vendor_user, only: [:show, :edit, :update, :destroy]

  def index
    @vendor_users = @vendor.users
    @vendor_user = Vendor::User.new
  end

  def show
  end

  def new
  end

  def create
    @vendor_user = @vendor.users.new(user_params)

    if @vendor_user.save
      redirect_to vendor_vendor_users_path,
                  flash: {success: "Admin user #{ @vendor_user.email } created."}
    else
      redirect_to vendor_vendor_users_path,
                  flash: {error: @vendor_user.errors.full_messages.to_sentence }
    end
  end

  def edit
    if session[:vendor_user]
      @vendor_user = session[:vendor_user] 
      session[:vendor_user] = nil
    end
  end

  def update
    authorize! :manage, @vendor_user
    
    if @vendor_user.update(user_params)
      redirect_to vendor_vendor_users_path,
                  flash: {success: "Admin user #{ @vendor_user.email } updated."}
    else
      session[:vendor_user] = params[:vendor_user]
      redirect_to vendor_vendor_user_path(@vendor_user),
                  flash: {error: @vendor_user.errors.full_messages.to_sentence }
    end
  end

  def destroy
    if @vendor.users.count > 1 && @vendor_user.destroy
      redirect_to vendor_vendor_users_path,
    	          flash: {success: "Deleted #{ @vendor_user.email }" }
    else
      redirect_to vendor_vendor_users_path,
                  flash: {error: "Cannot delete #{ @vendor_user.email }." }
    end
  end

  private

  def set_vendor_user
    @vendor_user = @vendor.users.find_by_id(params[:id])
  end

  def user_params
    params.require(:vendor_user).
           permit(:email, :password, :password_confirmation, :permission_level)
  end

end
