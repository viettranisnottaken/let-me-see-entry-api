class User < ApplicationRecord
  belongs_to :school

  scope :by_name, ->(name) do
    where("users.name LIKE :name", name: "%#{name}%") if name.present?
  end

  scope :by_school_name, ->(school_name) do
    joins(:school)
    .where("schools.name LIKE :school_name", school_name: "%#{school_name}%") if school_name.present?
  end

  scope :by_gender, ->(gender) do
    where(gender: gender) if gender.present?
  end

  scope :birthdate_between, -> (from, to = Time.zone.now) do
    where("birthdate BETWEEN ? AND ?", from, to) if from.present?
  end

  enum gender: { male: 0, female: 1, other: 2 }
end
