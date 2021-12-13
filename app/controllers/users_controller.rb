class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy banner ]
  before_action :logged_in, except: %i[ index main login new create destroy update]
  before_action :is_user, only: %i[ show banner ]
  before_action :is_nuser, only: %i[ result buy ]

  @fLogin = false
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    temp = user_params["username"] 
    tempU = User.find_by(username:temp)
    if tempU != nil
      redirect_to main_path,alert: "Can't use this username"
    else
        respond_to do |format|
          if @user.save
            format.html { redirect_to main_path, notice: "User was successfully created." }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end  
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def main
    session[:user_id] = nil
    if @fLogin
      @user = User.find_by(username: @username)
    else
      @user = User.new
    end
  end

  def login
    luser = params[:user]
    @username = luser['username']
    @password = luser['password']
    @user = User.find_by(username: @username)
    respond_to do |format|
      if @user != nil 
        if @user.authenticate(@password.to_s)
          session[:user_id] = @user.id
          format.html { redirect_to "/banner/#{@user.id}", notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else 
          @fLogin = true
          format.html { redirect_to main_path, alert: "Wrong password"}
          format.json { render json: @user.errors, status: :unprocessable_entity}
        end
      else
        @fLogin = true
        @user = User.new
        format.html { redirect_to main_path ,alert: "Not found this user"}
        format.json { render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def banner
    id = params[:id]
    @user = User.find_by(id: id)
    @banners = Banner.all
    # @banner = @user.get_banner
  end

  def eachbanner
    @user = User.find_by(id: session[:user_id])
  end

  def inventory
    @user = User.find_by(id: session[:user_id])
  end

  def market
    @user = User.find_by(id: session[:user_id])
  end

  def result
    @user = User.find_by(id: session[:user_id])
    banner = Banner.find_by(bannername: params[:name])
    if params[:type] == "one"
      @user.buyGacha(100)
      @boxes =  banner.random_one(session[:user_id])
    elsif params[:type] == "five"
      @user.buyGacha(400)
      @boxes =  banner.five_random(session[:user_id])
    end
  end

  def buy
    @inventory = Inventory.find_by(id: params[:inventory_id])
    @user = User.find_by(id: session[:user_id])
    if @inventory.status == "for sale" 
      @user.buyItem(@inventory)
    end
  end


  private
    def logged_in
      if(session[:user_id])
        return true
      else
        redirect_to main_path, alert: "Please login."
      end
    end

    def is_user
      if(session[:user_id] != @user.id)
        redirect_to main_path, alert: "Log in with wrong user"
      else
        return true
      end
    end

    def is_nuser
      if(session[:user_id].to_s != params[:id])
        redirect_to main_path, alert: "Log in with wrong user"
      else
        return true
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :credit)
    end
end
