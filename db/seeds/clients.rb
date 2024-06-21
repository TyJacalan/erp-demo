# frozen_string_literal: true

Client.find_or_create_by!(name: 'Saha Global') do |client|
  client.abbreviation = 'SAHA'
  client.mission = 'To ensure access to safe and affordable drinking water for rural communities.'
  client.website = 'https://sahaglobal.org/'
  client.nonprofit_status = true
  client.issue_areas = ['water and sanitation', 'livelihood', 'rural development']
end

Client.find_or_create_by!(name: 'BOMA') do |client|
  client.abbreviation = 'BOMA'
  client.mission = "Eradicating extreme povert in Africa's drylands."
  client.website = 'https://boma.ngo/'
  client.nonprofit_status = true
  client.issue_areas = ['entrepreneurship', 'livelihood', 'food security', 'technology', 'rural development']
end

Client.find_or_create_by!(name: 'Lewa Wildlife Conservation') do |client|
  client.abbreviation = 'LWC'
  client.mission = 'To work as a model and catalyst for the conservation of wildlife and its habitat.'
  client.website = 'https://www.lewa.org/'
  client.nonprofit_status = true
  client.issue_areas = ['water and sanitation', 'livelihood', 'energy', 'food security', 'technology',
                        'rural development', 'wildlife', 'education']
end
