class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.valid?
      if resource.agree_terms
        super
      else
        resource.errors.add(:agree_terms, "Você precisa concordar com a Política de Privacidade e Termos de Uso")
        render :new
      end
    else
      resource.errors.delete(:agree_terms) # Remove a mensagem de erro padrão, caso exista

      unless resource.errors.empty?
        flash.now[:error] = resource.errors.full_messages.first
      end

      render :new
    end
  end

  # Restante do código do controlador...
end
