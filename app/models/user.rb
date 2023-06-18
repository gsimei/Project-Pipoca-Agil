class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :agree_terms, acceptance: { message: "Você deve concordar com os termos de privacidade" }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}\z/, message: "deve incluir pelo menos uma letra, um número e um caractere especial" }, on: :create
  validates :name, presence: { message: "O nome não pode ficar em branco" }, if: :should_validate?

  validates :date_of_birth, presence: { message: "A data de nascimento não pode ficar em branco" }, if: :should_validate?

  attr_accessor :should_validate

  private

  def should_validate?
    should_validate || new_record?
  end
end
