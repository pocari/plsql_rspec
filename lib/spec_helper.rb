#coding: Windows-31J

require 'ruby-plsql'
require_relative 'active_record_helper.rb'
require_relative 'models.rb'

ActiveSupport::LogSubscriber.colorize_logging = false
#ActiveRecord::Base.logger = Logger.new(STDOUT) #ログ表示する場合は有効にする

shared_context :each_example_with_rollback_transaction do |database_config|
  around do |example|
    helper = TransactionHelper.new database_config
    helper.with_rollback_transaction do
      plsql.connection = ActiveRecord::Base.connection.raw_connection
      example.run
    end
  end
end
