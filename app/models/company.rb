class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :notes, dependent: :destroy

  validates :name, :organization, :title, :state, :city, presence: true
  validates :status, inclusion: ["contacted", "uncontacted", "dead", "confirmed"]
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, }
                    validates :hire_count, numericality: { only_integer: true, }

  scope :contacted, -> { where status: "contacted"}
  scope :uncontacted, -> { where status: "uncontacted"}
  scope :confirmed, -> { where status: "confirmed"}
  scope :dead, -> { where status: "dead"}

  STATUS_OPTIONS = { "Uncontacted" => "uncontacted",
                     "Contacted" => "contacted",
                     "Confirmed" => "confirmed",
                     "Dead" => "dead"
                   }

  def self.company_count_by_status(status)
    send(status.to_sym).count
  end

  def self.company_count_by_city
    group(:city).count.sort_by { |_key, value| value }.pop(10).reverse
  end
end
