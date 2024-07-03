# frozen_string_literal: true

# Clear models

Location.destroy_all
Organization.destroy_all
Prospect.destroy_all
Client.destroy_all
Office.destroy_all

# Add locations
locations = [
  { street: '5th Ave', city: 'New York', state: 'NY', country: 'USA', latitude: '40.7128', longitude: '-74.0060' },
  { street: 'Market St', city: 'San Francisco', state: 'CA', country: 'USA', latitude: '37.7749',
    longitude: '-122.4194' },
  { street: 'Oxford St', city: 'London', state: 'England', country: 'UK', latitude: '51.5074', longitude: '-0.1278' },
  { street: 'Champs-Élysées', city: 'Paris', state: '', country: 'France', latitude: '48.8566', longitude: '2.3522' },
  { street: 'Via della Conciliazione', city: 'Rome', state: 'RM', country: 'Italy', latitude: '41.9028',
    longitude: '12.4964' },
  { street: 'Elliott Ave', city: 'Seattle', state: 'WA', country: 'USA', latitude: '47.6062', longitude: '-122.3321' },
  { street: 'Sherman Ave', city: 'Chicago', state: 'IL', country: 'USA', latitude: '41.8781', longitude: '-87.6298' }
]

Location.insert_all(locations)

location_ids = Location.pluck(:id)

# Add organizations

organizations = [
  { name: 'Bill & Melinda Gates Foundation', website: 'https://www.gatesfoundation.org',
    mission: 'To reduce inequity around the world.', organization_type: 0, location_id: location_ids.sample },
  { name: 'Google', website: 'https://www.google.com',
    mission: 'To organize the world’s information and make it universally accessible and useful.', organization_type: 1, location_id: location_ids.sample },
  { name: 'Open Society Foundations', website: 'https://www.opensocietyfoundations.org',
    mission: 'To build vibrant and tolerant democracies whose governments are accountable to their citizens.', organization_type: 0, location_id: location_ids.sample },
  { name: 'UNICEF', website: 'https://www.unicef.org',
    mission: 'To advocate for the protection of children’s rights, to help meet their basic needs and to expand their opportunities to reach their full potential.', organization_type: 0, location_id: location_ids.sample },
  { name: 'Amazon', website: 'https://www.amazon.com',
    mission: 'To be Earth’s most customer-centric company, where customers can find and discover anything they might want to buy online.', organization_type: 1, location_id: location_ids.sample },
  { name: 'Red Cross', website: 'https://www.redcross.org',
    mission: 'To prevent and alleviate human suffering in the face of emergencies by mobilizing the power of volunteers and the generosity of donors.', organization_type: 0, location_id: location_ids.sample },
  { name: 'Doctors Without Borders', website: 'https://www.doctorswithoutborders.org',
    mission: 'To provide lifesaving medical care to those most in need.', organization_type: 0, location_id: location_ids.sample },
  { name: 'World Wildlife Fund', website: 'https://www.worldwildlife.org',
    mission: 'To conserve nature and reduce the most pressing threats to the diversity of life on Earth.', organization_type: 0, location_id: location_ids.sample },
  { name: 'Habitat for Humanity', website: 'https://www.habitat.org',
    mission: 'To bring people together to build homes, communities, and hope.', organization_type: 0, location_id: location_ids.sample },
  { name: 'SAHA Global', website: 'https://www.sahaglobal.com',
    mission: 'To get the cleanest water to the hardest to reach people.', organization_type: :nonprofit, location_id: location_ids.sample },
  { name: 'BOMA', website: 'https://www.boma.ngo',
    mission: 'Empowering women to end extreme poverty', organization_type: :nonprofit, location_id: location_ids.sample },
  { name: 'Lewa Wildlife Conservation', website: 'https://www.lewa.org',
    mission: 'to work as a model and catalyst for the conservation of wildlife and its habitat.', organization_type: :nonprofit, location_id: location_ids.sample },
  { name: 'Oxfam', website: 'https://www.oxfam.org',
    mission: 'To tackle poverty and injustice worldwide.', organization_type: 0, location_id: location_ids.sample }
]

Organization.insert_all(organizations)

p 'Seeded clients'

# Add a prospect

user = User.find(1)
p user.full_name

gates_foundation = Organization.find_by(name: 'Bill & Melinda Gates Foundation')
habitat_for_humanity = Organization.find_by(name: 'Habitat for Humanity')

prospects = [
  { vision: 'To create a world where very person has the opportunity to lead a healthy, productive life.',
    founder: 'Bill and Melinda Gates',
    founding_year: 2000,
    organization_id: gates_foundation.id,
    created_by_id: user.id,
    updated_by_id: user.id },
  { vision: 'A world where everyone has a decent place to live.',
    founder: 'Millard and Linda Fuller',
    founding_year: 1976,
    organization_id: habitat_for_humanity.id,
    created_by_id: user.id,
    updated_by_id: user.id }
]

Prospect.insert_all(prospects)

p 'Seeded prospects'

# Add clients

clients = [
  { organization_id: Organization.find_by(name: 'SAHA Global').id,
    abbreviation: 'SAHA',
    issue_areas: ['water and sanitation', 'livelihood', 'rural development'] },
  { organization_id: Organization.find_by(name: 'BOMA').id,
    abbreviation: 'BOMA',
    issue_areas: ['entrepreneurship', 'livelihood', 'food security', 'technology', 'rural development'] },
  { organization_id: Organization.find_by(name: 'Lewa Wildlife Conservation').id,
    abbreviation: 'LWC',
    issue_areas: ['water and sanitation', 'livelihood', 'energy', 'food security', 'technology', 'rural development', 'wildlife', 'education'] }
]

Client.insert_all(clients)

p 'Seeded clients'

# Add office locations for one sample

office_location_ids = Location.where(city: %w[Seattle Chicago]).pluck(:id)

offices = office_location_ids.map do |location_id|
  { organization_id: gates_foundation.id, location_id: }
end

Office.insert_all(offices)
