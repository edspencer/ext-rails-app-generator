class Model < ActiveRecord::Base
  has_many :columns
  has_many :validations, :through => :columns
  has_many :associations
  belongs_to :site
  has_many :controllers
  
  validates_presence_of :site_id, :name
  
  def generate!
    Rails::Generator::Scripts::Generate.new.run(['generated_model', self.name, self])
  end
end
