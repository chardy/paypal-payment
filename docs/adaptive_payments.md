# How to Set Up a Payment Preapproval Using Adaptive Payments

https://www.x.com/developers/paypal/documentation-tools/adaptive-payments/how-to/ht_ap-basicPreapproval-curl-etc

Setting up a payment preapproval using Adaptive Payments requires:

  1. Setting up the preapproval.
  2. Redirecting the customer to PayPal for authorization.
  3. Optionally, retrieving data about the preapproval.
  4. Optionally, capturing a future payment.

When you use Adaptive Payments to set up payment preapprovals, the payment amounts can vary frequently.

Step 1: Set Up the Preapproval

  pp = PayPal::AdaptivePayments::Preapproval.new(
    :starting_date => Date.today,
    :ending_date => Date.today >> 12,
    :max_amount_per_payment => 35.0,
    :max_number_of_payments => 20,
    :max_total_amount_of_all_payments => 2000.0,
    :cancel_url => 'http://www.yourdomain.com/success.html',
    :return_url => 'http://www.yourdomain.com/cancel.html',
    :currency_code => 'USD'
  )

  response = pp.create

Step 2: Redirect the Customer to PayPal for Authorization

To get the preapproval url

  response.preapproval_url

Step 3: Retrieve Data about the Preapproval (Optional)

  details = pp.details

  Or

  details = PayPal::AdaptivePayments::Preapproval.new(:preapproval_key => pp.preapproval_key).details

Step 4: Capture a Future Payment (Optional)

  pp = PayPal::AdaptivePayments::Payment.new(
    :preapproval_key => preapproval_key,
    :receiver => { :amount => 10.0, :email => "test@example.com" },
    :currency_code => 'USD',
    :cancel_url => 'http://www.yourdomain.com/success.html',
    :return_url => 'http://www.yourdomain.com/cancel.html'
  )

  pp.pay


