
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    build_resource(sign_up_params)

    if params[:user][:agree_terms] == "1"
      if resource.save
        yield resource if block_given?
        resource.send_confirmation_instructions
        redirect_to email_confirmation_path, notice: 'Cadastro realizado com sucesso. Verifique seu email para confirmar o cadastro.'
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_to do |format|
          format.html { render :new }
          format.json { render json: resource.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = 'Você deve concordar com os termos de privacidade.'
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html { redirect_to new_user_registration_path }
        format.json { render json: { error: 'Você deve concordar com os termos de privacidade.' }, status: :unprocessable_entity }
      end
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update(account_update_params)
      bypass_sign_in resource, scope: resource_name
      redirect_to after_update_path_for(resource), notice: 'Conta atualizada com sucesso.'
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :email, :password, :password_confirmation, :agree_terms])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :date_of_birth, :email, :password, :password_confirmation])
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
