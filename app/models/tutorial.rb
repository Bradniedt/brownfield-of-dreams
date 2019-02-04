class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.tagged(user, params)
    user ? get_tagged_user(params) : get_tagged_not_user(params)
  end

  def self.untagged(user, params)
    user ? get_untagged_user(params) : get_untagged_not_user(params)
  end

  def self.get_tagged_user(params)
    tagged_with(params[:tag])
    .paginate(:page => params[:page], :per_page => 5)
  end

  def self.get_tagged_not_user(params)
    where(classroom: false).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
  end

  def self.get_untagged_user(params)
    all.paginate(:page => params[:page], :per_page => 5)
  end

  def self.get_untagged_not_user(params)
    all.where(classroom: false).paginate(:page => params[:page], :per_page => 5)
  end
end
