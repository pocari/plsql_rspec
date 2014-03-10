require_relative '../lib/spec_helper.rb'

describe "Sample Spec" do
  include_context :each_example_with_rollback_transaction, ConfigHelper[:db, :development]
  
  describe 'pl/sql test' do
    before do
      plsql.execute(<<-EOS)
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
    end
    
    after do
      plsql.execute('drop procedure hoge_procedure')
    end
    
    it "procedure test" do
      ret = {:p_foo => 20, :p_piyo => 30}
      expect(plsql.hoge_procedure(5)).to eq ret
    end
    
  end
end

