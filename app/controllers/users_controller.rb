class UsersController < ApplicationController
  # layout "dashboard"
  # before_filter :is_user_admin?, only: [:create, :update, :destroy]
  # after_action :add_user_to_account, only: [:create]
  # before_filter :authenticate_user!
  before_action :set_users_path
  respond_to :html, :json

  def index
    @new_user = User.new
    if !params[:user_type].blank?
	    if params[:user_type].downcase == 'staff'
			@users = User.where('user_type like ?', 'Staff')
			@upload_page = "#{users_upload_page_path}?user_type=staff"
		elsif params[:user_type].downcase == 'customer'
		  	@users = User.where('user_type like ?', 'Customer')
		  	@upload_page = "#{users_upload_page_path}?user_type=customer"
		else
			@users = User.all#ActsAsTenant.current_tenant.users if !ActsAsTenant.current_tenant.nil?
			@upload_page = users_upload_page_path
		end
	else
		@users = User.all#ActsAsTenant.current_tenant.users if !ActsAsTenant.current_tenant.nil?
		@upload_page = users_upload_page_path
	end
	respond_with(@users)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    @amount_sent = Payment.where(sender: @user).sum(:amount)
    @amount_received = Payment.where(recipient: @user).sum(:amount)
    # unless @user == current_user || current_user.is_admin
    #   redirect_to set_users_path, :alert => "Access denied."
    # end
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    @user.password = "12345678"#generate_random_password
    @user.is_admin = user_params[:is_admin] == "1"
    puts "Password >>>>>>>>>>>>> #{@user.password}"

    respond_to do |format|
      if @user.save
        # begin
        #   @user.account_id = current_user.accounts.first.id
        #   UserAccount.create! account_id: current_user.accounts.first.id, user_id: @user.id
        # rescue ActsAsTenant::Errors::TenantIsImmutable => e
        #   # puts ">>>>>>>>>> Something wrong here #{e.backtrace}"
        # end
        format.html { redirect_to set_users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { redirect_to set_users_path, alert: "User could not be added!" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_page
    @user = User.new
  end

  def delete_multiple
    deleted = 0
    params[:delete_users].split(',').each do |id|
      User.find_by(id: id).destroy
      deleted = deleted + 1
    end
    redirect_to set_users_path, notice: "You have deleted #{deleted} users."
  end

  def bulk_upload
    file = params[:user][:upload_file]
    is_xlsx = File.extname(file.original_filename) == ".xlsx"
    is_xls = File.extname(file.original_filename) == ".xls"
    is_csv = File.extname(file.original_filename) == ".csv"
    imported = 0
    duplicates = 0

    if is_xlsx
      xlsx_file = nil

      xlsx_file = params[:user][:upload_file]
      if params[:user][:upload_file].is_a? ActionDispatch::Http::UploadedFile
        xlsx_file = params[:user][:upload_file].tempfile
      end

      doc = SimpleXlsxReader.open(xlsx_file)          
      users = doc.sheets.first.rows[1..doc.sheets.first.rows.length]     
      puts ">>>>>>>>>>>>>> #{users}" 
      # users = users.collect { |r| [r.first,r.last] }  
      import_users users      

      # render json: { success: true, imported: imported, duplicates: duplicates }
      redirect_to set_users_path, notice: "Import successful"
    elsif is_csv
      csv_text = nil
      if !params[:user][:upload_file].is_a? ActionDispatch::Http::UploadedFile
        csv_text = File.read(params[:user][:upload_file])
      else
        csv_text = File.read(params[:user][:upload_file].tempfile)
      end

      csv = CSV.parse(csv_text, :headers => true)   
      users = csv.collect { |r| [r[0],r[1]] }
      import_users users      

      # render json: { success: true, imported: imported, duplicates: duplicates }
      redirect_to set_users_path, notice: "Import successful"
   elsif is_xls
      if file.is_a? ActionDispatch::Http::UploadedFile
        xls_file = file.tempfile
      else
        xls_file = file
      end
      Spreadsheet.open(xls_file.path) do |book|
        users = book.worksheet(0).collect { |r| [r[0],r[1].to_i.to_s ] }
        import_users users[1..users.length]        
      end
      # render json: { success: true, imported: imported, duplicates: duplicates }
      redirect_to set_users_path, notice: "Import successful"
    else
      render json: { success: false, error: "Not a valid users file" }
    end
  end

  def import_users array
    # :name, phone_number, email, user_type
    puts "Params:\n1. #{params[:user][:user_type]}\n2. #{params[:user_type]}\n3. #{user_params[:user_type]}\n4. #{params[:user_type].blank?}"
    array.each do |element|
      puts "Before:\n#{element}"
      if element[3].nil?
      	if !user_params[:user_type].blank?
      		element[3] = params[:user][:user_type]
      	end
      end
      puts "After:\n#{element}"
      if !element.include?(nil)
        name = element[0]
        phone_number = element[1]
        email = element[2]
        user_type = element[3]
        user_details = {name: name, phone_number: phone_number}
        user_details[:email] = email
        user_details[:user_type] = user_type
        if User.find_by(phone_number: phone_number).nil?
          user = User.new user_details
          user.password = "12345678"
          user.save!
        end
      end
    end
  end

  def update
	  @user = User.find(params[:id])
	  respond_to do |format|
	    if @user.update(user_params)
	      format.html { redirect_to @user, notice: 'User was successfully updated.' }
	      format.json { render :show, status: :ok, location: @user }
	    else
	      format.html { render :edit }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
	    end
	  end
	end

  private
    def is_user_admin?
      unless current_user.is_admin
        redirect_to set_users_path, alert: "You are not authorized to add users!"
      end
    end

    def set_users_path
    	path = users_path
    	if !params[:user_type].nil?
	    	if params[:user_type].downcase == "staff"
	    		path = "#{users_path}?user_type=staff"
	    	elsif params[:user_type].downcase == "customer"
	    		path = "#{users_path}?user_type=customer"
	    	else
	    		path = users_path
	    	end
    	end
    	path
    end

  def user_params
    params.require(:user).permit(:name, :email, :password, :is_admin, :account_id, :phone_number, :user_type)
  end
end
