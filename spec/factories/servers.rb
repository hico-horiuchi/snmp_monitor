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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :server do
    ip_address      'localhost'
    community       'public'
    max_cpu_core    6
    assign_cpu_core 1
    cpu_tdp         95
  end
end
