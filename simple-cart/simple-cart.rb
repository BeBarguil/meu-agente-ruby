# Simple Cart - Shopping Cart System
# A command-line shopping cart application built with Ruby

# ============================================
# PRODUCT DATA
# ============================================

PRODUCTS = {
  "apple" => { price: 1.50, stock: 10 },
  "banana" => { price: 0.75, stock: 8 },
  "orange" => { price: 2.00, stock: 6 },
  "mango" => { price: 3.50, stock: 4 },
  "grape" => { price: 4.00, stock: 5 }
}.freeze

# ============================================
# METHODS
# ============================================

def display_header(text)
  puts "-" * 40
  puts text
  puts "-" * 40
end

def display_products(products)
  puts "\nAvailable products:\n\n"
  products.each do |item, info|
    status = info[:stock] > 0 ? "#{info[:stock]} in stock" : "out of stock"
    puts "  • #{item.capitalize}: $#{'%.2f' % info[:price]} (#{status})"
  end
  puts
end

def get_product_choice
  puts "Which product would you like to buy? (or 'quit' to finish)"
  print "> "
  gets.chomp.downcase.strip
end

def get_quantity(product_name)
  puts "How many #{product_name}(s) would you like?"
  print "> "
  gets.chomp.to_i
end

def valid_quantity?(quantity, stock, product_name)
  if quantity <= 0
    puts "⚠️  Invalid quantity. Please enter a number greater than zero."
    return false
  end

  if quantity > stock
    puts "⚠️  Sorry, we only have #{stock} unit(s) of #{product_name}."
    return false
  end

  true
end

def add_to_cart(cart, product_name, quantity)
  existing_item = cart.find { |item| item[:item] == product_name }

  if existing_item
    existing_item[:quantity] += quantity
  else
    cart << { item: product_name, quantity: quantity }
  end

  puts "✓ #{quantity}x #{product_name} added to cart!"
end

def display_cart(cart, products)
  if cart.empty?
    puts "Your cart is empty."
    return 0
  end

  puts "\nOrder summary:\n\n"

  total = 0
  cart.each do |info|
    item = info[:item]
    quantity = info[:quantity]
    price = products[item][:price]
    subtotal = quantity * price

    puts "  #{item.capitalize}: #{quantity} x $#{'%.2f' % price} = $#{'%.2f' % subtotal}"
    total += subtotal
  end

  total
end

# ============================================
# MAIN PROGRAM
# ============================================

def run_store
  products = PRODUCTS.transform_values { |v| v.dup }
  cart = []

  display_header("Welcome to Simple Cart 🛒")
  display_products(products)

  loop do
    answer = get_product_choice
    break if answer == "quit"

    unless products.key?(answer)
      puts "⚠️  Product '#{answer}' not found. Please try again.\n\n"
      next
    end

    if products[answer][:stock] <= 0
      puts "⚠️  Sorry, #{answer} is out of stock.\n\n"
      next
    end

    quantity = get_quantity(answer)
    next unless valid_quantity?(quantity, products[answer][:stock], answer)

    add_to_cart(cart, answer, quantity)
    products[answer][:stock] -= quantity
    puts
  end

  display_header("Checkout")
  total = display_cart(cart, products)

  puts
  puts "-" * 40
  puts "TOTAL: $#{'%.2f' % total}"
  puts "-" * 40
  puts "\nThank you for shopping with Simple Cart! 👋"
end

run_store
