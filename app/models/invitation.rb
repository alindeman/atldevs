class Invitation
  include Virtus.model
  include ActiveModel::Model

  attribute :email, String
  validates :email, presence: true

  def enqueue
  end
end
