require 'active_support/all'
require 'ruby-plsql'
require_relative 'active_record_helper'
require_relative 'models'
require_relative 'config_helper'

ActiveSupport::LogSubscriber.colorize_logging = false
#ActiveRecord::Base.logger = Logger.new(STDOUT)

shared_context :each_example_with_rollback_transaction do |database_config|
  around do |example|
    helper = TransactionHelper.new database_config
    helper.with_rollback_transaction do
      begin
        plsql.activerecord_class = ActiveRecord::Base
        example.run
      ensure
        plsql.connection.drop_session_ruby_temporary_tables
      end
    end
  end
end
