require 'pry'

def consolidate_cart(cart)
  groceries = {}
  count = 0
    cart.each do |item|
      item.each do |name, value|
        groceries[name] = value
        groceries[name][:count] ||= 0
        groceries[name][:count] += 1
      end #item each
    end #cart each
  return groceries
end #method

def apply_coupons(cart, coupon)
  coupon.each do |item|
    name_of_item = item[:item]
    if cart.has_key?(name_of_item) == true && cart[name_of_item][:count] >= item[:num]
      cart[name_of_item][:count] = cart[name_of_item][:count] - item[:num]
      new_item = name_of_item + (" W/COUPON")
      puts cart.has_key?(new_item)
      if cart.has_key?(new_item) == false
        cart[new_item] = {:price => item[:cost], :clearance => cart[name_of_item][:clearance], :count => 1}
      else
        cart[new_item][:count] += 1
      end #if cart key new item
    end #if cart key
  end #coupon each
  return cart
end #method

def apply_clearance(cart)
  cart.each do |item, stat|
    if stat[:clearance]
      stat[:price] = (stat[:price] * 0.8).round(2)
    end #if cart clearance
  end #cart each
  return cart
end #method

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  cart_w_coupons = apply_coupons(consol_cart, coupons)
  final = apply_clearance(cart_w_coupons)
  total = 0
  final.each do |name, stat|
    total += stat[:price]* stat[:count]
  end #final each
  total = total * 0.9 if total > 100
  return total
end #method
