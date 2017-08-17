
def consolidate_cart(cart)

  new_hash = {}

  cart.each do |food|
      food.each do |food_data, food_info|
        if new_hash.has_key?(food_data)
          new_hash[food_data][:count] += 1
        else
          new_hash[food_data] = food_info
          new_hash[food_data][:count] = 1
      end
    end
  end
  new_hash
end


def apply_coupons(cart, coupons)
  coupon_hash = {}

  coupons.each do |coupon_data|
	  cart.each do |item, data|
	  	if coupon_data[:item] == item && coupon_data[:num] <= data[:count]
	  		coupon_item = "#{item} W/COUPON"

	  		if coupon_hash.key?(coupon_item)
		  		coupon_hash[coupon_item][:count] += 1
		  	else
		  		coupon_hash[coupon_item] = {
		  			price: coupon_data[:cost],
		  			clearance: data[:clearance],
		  			count: 1
		  		}
		  	end
	  		cart[item][:count] -= coupon_data[:num]
	  	end
	  end
	end
	coupon_hash.each do |item, data|
	  cart[item] = data
	end
	cart
end

=begin
#did not work

def apply_clearance(cart)
  clearance_cart = {}

  cart.each do |item, info|
    if info[:clearance] == true

      new_price = info[:price]

      clearance_cart[item] = {
        price: (new_price * 0.80),
        clearance: info[:clearance],
        count: info[:count]
      }
    else
      clearance_cart[item] = {
        price: info[:cost],
        clearance: info[:clearance],
        count: info[:count]
      }

    end
  end
  clearance_cart
end
=end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price]*0.8).round(2)
    end
  end
end


def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)
  with_coupons = apply_coupons(consolidated_cart,coupons)
  with_clearance = apply_clearance(with_coupons)

  total = 0

  with_clearance.each { |key, value|
    total += (value[:price] * value[:count])
  }

    if total >= 100
      total = total*0.9
    else

  end
  total
end
