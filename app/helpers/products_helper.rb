module ProductsHelper
  def get_star star, time
    star > time ? "yellow-star" : "gray-star"
  end
end
