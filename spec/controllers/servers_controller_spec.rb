require 'rails_helper'

RSpec.describe ServersController, :type => :controller do
  describe '#index' do
    before do
      sign_in FactoryGirl.create( :user )
      get :index
    end
    it { expect( response ).to render_template :index }
    it { expect( response ).to be_success }
  end

  describe '#new' do
    before do
      sign_in FactoryGirl.create( :user )
      xhr :get, :new
    end
    it { expect( response ).to be_success }
  end

  describe '#create' do
    before do
      sign_in FactoryGirl.create( :user )
      server_params = FactoryGirl.attributes_for( :server )
      xhr :post, :create, server: server_params
    end
    it { expect( response ).to be_success }
    it { expect( assigns[:server] ).to eq( Server.last ) }
    it { expect( assigns[:result] ).to be_truthy }
  end

  describe '#edit' do
    before do
      sign_in FactoryGirl.create( :user )
      server = FactoryGirl.create( :server )
      xhr :get, :edit, id: server.id
    end
    it { expect( response ).to be_success }
  end

  describe '#update' do
    before do
      sign_in FactoryGirl.create( :user )
      server = FactoryGirl.create( :server )
      server_params = FactoryGirl.attributes_for( :server )
      xhr :patch, :update, id: server.id, server: server_params
    end
    it { expect( response ).to be_success }
    it { expect( assigns[:server] ).to eq( Server.last ) }
    it { expect( assigns[:result] ).to be_truthy }
  end

  describe '#delete' do
    before do
      sign_in FactoryGirl.create( :user )
      server = FactoryGirl.create( :server )
      xhr :get, :delete, id: server.id
    end
    it { expect( response ).to be_success }
  end

end
