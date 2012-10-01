module Devise
  module Models
    module Strengthened
      def self.included(base)
        base.class_eval do
          validate :strong_enough_password?, :if => :password_required?
        end
      end

      protected

      MINIMUM_ENTROPY = 15

      def strong_enough_password?
        entropy = PassphraseEntropy.of(password)
        if entropy < MINIMUM_ENTROPY
          self.errors.add :password, :insufficient_entropy, entropy: entropy,
                          minimum_entropy: MINIMUM_ENTROPY
        end
      end
    end
  end
end
