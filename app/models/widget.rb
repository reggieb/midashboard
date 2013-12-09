class Widget < ActiveRecord::Base
  attr_accessible :container, :data_type, :description, :name, :root_uri, :title

  def data
    ApiClient.new(root_uri).json
  end
end
