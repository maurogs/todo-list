class List < ApplicationRecord
  COLORS = %w[indigo violet pink rose orange amber emerald sky].freeze
  ICONS = %w[📝 🏠 💼 🛒 🎯 ✈️ 📚 💪 🎉 💡 🍳 🌱 📦].freeze

  belongs_to :user
  has_many :tasks, -> { order(:position, :id) }, dependent: :destroy

  before_validation :set_position, on: :create

  validates :name, presence: { message: "no puede estar vacío" }, length: { maximum: 40 }
  validates :color, inclusion: { in: COLORS }
  validates :icon, inclusion: { in: ICONS }

  def pending_tasks = tasks.reject(&:completed?)
  def completed_tasks = tasks.select(&:completed?).sort_by(&:completed_at).reverse

  def pending_count = tasks.where(completed_at: nil).count
  def total_count = tasks.count

  # Percentage (0-100) of completed tasks.
  def progress
    total = total_count
    total.zero? ? 0 : ((total - pending_count) * 100.0 / total).round
  end

  private
    def set_position
      self.position = (user.lists.maximum(:position) || -1) + 1 if position.to_i.zero? && user
    end
end
