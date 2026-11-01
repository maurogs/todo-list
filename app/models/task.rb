class Task < ApplicationRecord
  belongs_to :list
  has_one :user, through: :list

  enum :priority, { none: 0, low: 1, medium: 2, high: 3 }, prefix: true

  before_validation :set_position, on: :create

  validates :title, presence: { message: "no puede estar vacío" }, length: { maximum: 200 }
  validates :notes, length: { maximum: 2000 }

  scope :pending, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :due_by, ->(date) { pending.where(due_on: ..date) }

  def completed? = completed_at.present?
  def overdue? = !completed? && due_on.present? && due_on < Date.current
  def due_today? = due_on == Date.current

  def toggle!
    update!(completed_at: completed? ? nil : Time.current)
  end

  private
    def set_position
      self.position = (list.tasks.maximum(:position) || -1) + 1 if position.to_i.zero? && list
    end
end
