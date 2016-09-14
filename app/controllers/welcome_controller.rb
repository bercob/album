class WelcomeController < ApplicationController
  def index
    logger.info 'WelcomeController::index'
    image = MiniMagick::Image.open('app/assets/images/other-product.jpg')
    logger.info "MiniMagick::Image.open: #{image.inspect}"
    logger.info "image.resize: #{image.resize '100x100'}"
    logger.info "image.write: #{image.write 'app/assets/images/other-product-thumbnail.jpg'}"

  end
end
