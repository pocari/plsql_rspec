require 'active_record'

class TransactionHelper
  def initialize(config)
    @config = config
  end
  
  def with_connection
    ActiveRecord::Base.establish_connection(@config)
    yield
  ensure
    ActiveRecord::Base.connection.close
  end
  
  def with_transaction
    with_connection do
      ActiveRecord::Base.transaction do
        yield
      end
    end
  end
  
  def with_rollback_transaction
    with_transaction do
      begin
        yield
        raise ActiveRecord::Rollback
      end
    end
  end
end
