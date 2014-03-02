require_relative '../lib/spec_helper.rb'

describe "Sample Spec" do
  include_context :each_example_with_rollback_transaction, YAML.load_file("../config/config.yaml")["db"]["development"]
  
  describe 'pl/sql test' do
    it "function test" do
      function_src = <<-EOS
      create or replace function hoge_function (
        p_hoge in number
      ) return number
      is
      begin
        return p_hoge * 5;
      end;
      EOS
      
      ActiveRecord::Base.connection.execute(function_src)
      expect(plsql.hoge_function(5)).to eq 25
    end
    
    it "procedure test" do
      function_src = <<-EOS
      create or replace procedure hoge_procedure (
        p_hoge in number,
        p_foo  out number,
        p_piyo  out number
      )
      is
      begin
        p_foo  := p_hoge * 4;
        p_piyo := p_hoge * 6;
      end;
      EOS
      
      ActiveRecord::Base.connection.execute(function_src)
      ret = {:p_foo => 20, :p_piyo => 30}
      expect(plsql.hoge_procedure(5)).to eq ret
    end
    
  end
end

