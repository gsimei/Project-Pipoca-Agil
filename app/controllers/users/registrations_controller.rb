class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

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

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :date_of_birth, :email, :password, :password_confirmation, :agree_terms])
  end

  def after_sign_up_path_for(resource)
    confirmation_message_path
  end
end
