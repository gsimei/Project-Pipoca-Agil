class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

         validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}\z/, message: "deve incluir pelo menos uma letra, um número e um caractere especial" }
         validates :agree_terms, acceptance: { message: "Você deve concordar com a Política de Privacidade e Termos de Uso" }
         validates :name, presence: { message: "O nome não pode ficar em branco" }
         validates :date_of_birth, presence: { message: "A data de nascimento não pode ficar em branco" }
         # validates :email, presence: { message: "O e-mail não pode ficar em branco" }


end
