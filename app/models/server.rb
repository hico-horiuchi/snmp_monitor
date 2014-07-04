# == Schema Information
#
# Table name: servers
#
#  id              :integer          not null, primary key
#  user_id         :integer          default(0), not null
#  ip_address      :string(255)      default(""), not null
#  community       :string(255)      default(""), not null
#  max_cpu_core    :integer          default(0), not null
#  assign_cpu_core :integer          default(0), not null
#  cpu_tdp         :integer          default(0), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Server < ActiveRecord::Base
  validates :ip_address, :community, :max_cpu_core, :assign_cpu_core, :cpu_tdp, presence: true
  scope :id_is, -> ( id ) { where( id: id ).first }
  belongs_to :user
end
