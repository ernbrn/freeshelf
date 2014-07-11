class Book < ActiveRecord::Base
  paginates_per 15
  acts_as_taggable

  validates :title, presence: true
  validates :author, presence: true

  mount_uploader :cover, CoverUploader
  mount_uploader :document, DocumentUploader

  extend FriendlyId
  friendly_id :slug_candidates, :use => [:slugged, :history]
  validates_presence_of :title, :slug

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def slug_candidates
    [:title, [:title, :author]]
  end

  def link
    if document?
      document.url
    else
      self.url
    end
  end
end
