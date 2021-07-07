class Application
  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      # show_cart_items
      if cart_empty?
        resp.write "Your cart is empty"
      else
        show_cart_items(resp)
      end
    elsif req.path.match(/add/)
      add_item_search(req, resp)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  private

  def handle_search(search_term)
    if @@items.include?(search_term)
      "#{search_term} is one of our items"
    else
      "Couldn't find #{search_term}"
    end
  end

  def cart_empty?
    @@cart.size == 0
  end

  def show_cart_items(resp)
    @@cart.each { |item| resp.write "#{item}\n" }
  end

  def add_item_search(req, resp)
    add_item = req.params["item"]

    if @@items.include?(add_item)
      @@cart << add_item
      resp.write "added #{add_item}"
    else
      resp.write "We don't have that item"
    end
  end
end
