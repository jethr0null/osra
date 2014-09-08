class Orphan < ActiveRecord::Base
  validates :name, presence: true
  validates :father_name, presence: true
  validates :father_is_martyr, inclusion: {in: [true, false] }, exclusion: { in: [nil]}
  validates :father_date_of_death, presence: true, date_not_in_future: true
  validates :mother_name, presence: true
  validates :mother_alive, inclusion: {in: [true, false] }, exclusion: { in: [nil]}
  validates :date_of_birth, presence: true, date_not_in_future: true
  validates :gender, presence: true, inclusion: {in: %w(Male Female) } # TODO: DRY list of allowed values
  validates :contact_number, presence: true
  validates :sponsored_by_another_org, inclusion: {in: [true, false] }, exclusion: { in: [nil]}
  validates :minor_siblings_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :original_address, presence: true
  validates :current_address, presence: true

  belongs_to :original_address, class_name: 'Address'
  belongs_to :current_address, class_name: 'Address'
end