= PayPal Payment

PayPal API Client for Adaptive Payments, Invoice and Express Checkout.

== Installation (Gemfile)

  gem 'paypal-payment', :git => 'vendor@appcepted.com:/home/vendor/pp_paypal'

== Usage

First, you need to set up your credentials:

  require "paypal-payment"

  PayPal::Api.configure do |config|
    config.sandbox    = true
    config.username   = "chardy_api1.gmail.com"
    config.password   = "8DTSWBZC7GDR3T4X"
    config.signature  = "AG-8mOpuFhFyFOYHlaTUYn3Syf15AWJKRnfHMVsmCtC3DK51-ENEPqLS"
  end

== Ref: https://www.x.com/developers/paypal/documentation-tools/express-checkout/how-to/ht_ec-recurringPaymentProfile-curl-etc

== 1. Express Checkout - Recurring (authorization)

  payment = PayPal::ExpressCheckout::Payment.new(
    :payment_action     => "Authorization",
    :description        => "Awesome - Monthly Subscription",
    :notify_url         => "http://example.com/paypal/ipn",
    :amount             => "9.00", # not bill yet
    :currency           => "USD"
  )

  billing = PayPal::ExpressCheckout::Billing.new(
    :type               => 'RecurringPayments',
    :description        => "Awesome - Monthly Subscription"
  )

  ppc = PayPal::ExpressCheckout::Checkout.new({
    :return_url         => "http://example.com/thank_you?app_name=camera_app",
    :cancel_url         => "http://example.com/canceled",
    :billings           => [ billing ],
    :payments           => [ payment ]
  })

  response = ppc.checkout

  response.valid?
  response.checkout_url
  # https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&token=InsertTokenHere

  token = response.token
  payer_id = response.details.payer_id

  rco = PayPal::ExpressCheckout::Checkout.new(:token => token)
  payer_id = rco.details.payer_id

== 1.a after click the checkout_url, make payment, redirect to return_url and paypal will return 

  TOKEN=token_value
  &BILLINGAGREEMENTACCEPTEDSTATUS=1
  &ACK=Success
  &PAYERID=3TXTXECKF1234

== 2. Express Checkout - Recurring

  ppr = PayPal::ExpressCheckout::Recurring.new({
    :amount                         => "9.00",
    :initial_amount                 => "9.00",
    :failed_initial_action          => :cancel,
    :currency                       => "USD",
    :description                    => "Awesome - Monthly Subscription",
    :frequency                      => 1,
    :token                          => token,
    :period                         => :monthly,
    :reference                      => "1234",
    :payer_id                       => payer_id,
    :start_at                       => Time.now,
    :max_failed_payments            => 1,
    :auto_bill_outstanding          => :next_billing
  })

  ppr.create_profile
  ppr.profile_status
  ppr.profile_id

== 3. Express Checkout - Recurring - manage profile
  
  ppr = PayPal::ExpressCheckout::Recurring.new(:profile_id => "I-1RFWFFS16BF4")
  ppr.suspend
  ppr.success?

  ppr.profile # see profile_spec.rb

  ppr.reactivate

  ppr.cancel # cannot reactivate

== 4. Express Checkout - Recurring - update profile

  ppr = PayPal::ExpressCheckout::Recurring.new(:profile_id => "I-1RFWFFS16BF4")

  PayPal::ExpressCheckout::Recurring.new({
    :description => "Awesome - Monthly Subscription (Updated)",
    :amount      => "10.00",
    :currency    => "BRL",
    :note        => "Changed Plan",
    :profile_id  => profile_id
  })

=====

== 1. Express Checkout - Sale

  payment = PayPal::ExpressCheckout::Payment.new(
    :payment_action     => "Sale",
    :description        => "Awesome - Sale",
    :notify_url         => "http://example.com/paypal/ipn",
    :amount             => "9.00",
    :currency           => "USD"
  )

  ppc = PayPal::ExpressCheckout::Checkout.new({
    :return_url         => "http://example.com/thank_you",
    :cancel_url         => "http://example.com/canceled",
    :payments           => [ payment ]
  })

  response = ppc.checkout
  response.valid?
  response.checkout_url

== 1.a after click the checkout_url, make payment, redirect to return_url and paypal will return 

  TOKEN=token_value
  &ACK=Success

== 2. Express Checkout - Sale

  payment = PayPal::ExpressCheckout::Payment.new(
    :payment_action     => "Sale",
    :description        => "Awesome - Sale",
    :notify_url         => "http://example.com/paypal/ipn",
    :amount             => "9.00",
    :currency           => "USD"
  )

  checkout = PayPal::ExpressCheckout::Checkout.new(:token => token)
  payer_id = checkout.details.payer_id

  checkout = PayPal::ExpressCheckout::Checkout.new(
    :token              => token,
    :payer_id           => payer_id,
    :payments           => [payment]
  )
  checkout.pay

== 3. Express Checkout - Sale - Manage

  payment = PayPal::ExpressCheckout::Payment.new(:transaction_id => transaction_id)












