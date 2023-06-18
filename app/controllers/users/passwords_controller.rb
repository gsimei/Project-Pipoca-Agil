class Users::PasswordsController < Devise::PasswordsController
  # GET /users/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /users/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty? && resource.update(password_params)
      logger.info("Senha atualizada com sucesso para o usuário #{resource.email}")
      resource.unlock_access! if unlockable?(resource)

      flash[:notice] = "Senha atualizada com sucesso. Faça login com sua nova senha."
      redirect_to new_user_session_path
    else
      logger.error("Erro ao atualizar a senha para o usuário #{resource.email}")
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
