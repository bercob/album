class WelcomeController < ApplicationController
  def index
    image = Magick::Image.read('app/assets/images/other-product.jpg').first
  end
end
