class WelcomeController < ApplicationController
  def index
    Rails.logger.info 'WelcomeController::index'
    image = MiniMagick::Image.open 'app/assets/images/other-product.jpg'
    image.resize '100x100'
    image.write 'public/thumbnails/other-product-thumbnail.jpg'
  end
end
