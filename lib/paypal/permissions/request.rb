module PayPal::Permissions
  class Request < PayPal::Common::Request

    METHODS = {
      :cancel_permissions         => "CancelPermissions",
      :get_access_token           => "GetAccessToken",
      :get_advance_personal_data  => "GetAdvancedPersonalData",
      :get_basic_personal_data    => "GetBasicPersonalData",
      :get_permissions            => "GetPermissions",
      :request_permissions        => "RequestPermissions"
    }

    SCOPE_TYPES = {
      :express_checkout => 'EXPRESS_CHECKOUT', #- Express Checkout
      :direct_payment => 'DIRECT_PAYMENT', # Direct payment by debit or credit card
      :settlement_consolidation => 'SETTLEMENT_CONSOLIDATION', # Settlement consolidation
      :settlement_reporting => 'SETTLEMENT_REPORTING', # Settlement reporting
      :auth_capture => 'AUTH_CAPTURE', # Payment authorization and capture
      :mobile_checkout => 'MOBILE_CHECKOUT', # Mobile checkout
      :billing_agreement => 'BILLING_AGREEMENT', # Billing agreements
      :reference_transaction => 'REFERENCE_TRANSACTION', # Reference transactions
      :air_travel => 'AIR_TRAVEL', # Express Checkout for UTAP
      :mass_pay => 'MASS_PAY', # Mass pay
      :transaction_details => 'TRANSACTION_DETAILS', # Transaction details
      :transaction_search => 'TRANSACTION_SEARCH', # Transaction search
      :recurring_payments => 'RECURRING_PAYMENTS', # Recurring payments
      :account_balance => 'ACCOUNT_BALANCE', # Account balance
      :encrypted_website_payment => 'ENCRYPTED_WEBSITE_PAYMENTS', # Encrypted website payments
      :refund => 'REFUND', # Refunds
      :non_reference_credit => 'NON_REFERENCED_CREDIT', # Non-referenced credit
      :button_manager => 'BUTTON_MANAGER', # Button Manager
      :manage_pending_transaction_status => 'MANAGE_PENDING_TRANSACTION_STATUS', # includes ManagePendingTransactionStatus
      :recurring_report => 'RECURRING_PAYMENT_REPORT', # Reporting for recurring payments
      :extended_processing_report => 'EXTENDED_PRO_PROCESSING_REPORT', # Extended Pro processing
      :exception_processing_report => 'EXCEPTION_PROCESSING_REPORT', # Exception processing
      :account_management => 'ACCOUNT_MANAGEMENT_PERMISSION', # Account Management Permission (MAM)
      :basic_personal_data => 'ACCESS_BASIC_PERSONAL_DATA', # User attributes
      :advance_personal_data => 'ACCESS_ADVANCED_PERSONAL_DATA', # User attributes
      :invoicing => 'INVOICING'
    }

    def api
      PayPal::Permissions::Api
    end

    # Returns the actual api endpoint base on method
    #
    def method_endpoint(method)
      "#{api.api_endpoint}/#{METHODS.fetch(method, method.to_s)}"
    end
  end
end