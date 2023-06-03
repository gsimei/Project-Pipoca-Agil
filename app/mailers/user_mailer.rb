class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = "Instruções de Confirmação Pipoca Ágil"
    super
  end
end
