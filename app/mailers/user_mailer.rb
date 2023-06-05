class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = "Confirmação de Cadastro: Bem-vindo(a) ao Pipoca Ágil"
    super
  end
end
