class WelcomeController < ApplicationController
  def index
    image = MiniMagick::Image.open('app/assets/images/other-product.jpg')
    Rails.logger.debug "MiniMagick::Image.open: #{image.inspect}"
    Rails.logger.debug "image.resize: #{image.resize '100x100'}"
    Rails.logger.debug "image.write: #{image.write 'app/assets/images/other-product-thumbnail.jpg'}"

  end
end
