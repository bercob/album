class WelcomeController < ApplicationController
  def index
    image = MiniMagick::Image.open('app/assets/images/other-product.jpg')
    image.resize '100x100'
    image.write 'app/assets/images/other-product-thumbnail.jpg'

  end
end
