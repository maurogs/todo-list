class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :lists, -> { order(:position, :id) }, dependent: :destroy
  has_many :tasks, through: :lists

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :name, with: ->(n) { n.strip }

  validates :name, presence: { message: "no puede estar vacío" }, length: { maximum: 60 }
  validates :email_address, presence: { message: "no puede estar vacío" },
                            uniqueness: { message: "ya está registrado" },
                            format: { with: URI::MailTo::EMAIL_REGEXP, message: "no es válido", allow_blank: true }
  validates :password, length: { minimum: 8, message: "debe tener al menos 8 caracteres" }, allow_nil: true

  def first_name
    name.split.first
  end
end
