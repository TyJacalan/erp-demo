# frozen_string_literal: true

TaskCategory.insert_all(
  [
    {
      department: 'Research',
      name: 'Prospect Research'
    },
    {
      department: 'Account Management',
      name: 'Moves Action Plan'
    },
    {
      department: 'Writing',
      name: 'Proposal V1'
    },
    {
      department: 'Writing',
      name: 'Proposal V2'
    },
    {
      department: 'Editorial',
      name: 'Edits V1'
    }
  ]
)

10.times do |i|
  Task.create(
    name: "Task #{i}",
    hours: rand(0..8),
    deadline: Date.today + 7,
    user_id: 1,
    client_id: 1,
    task_category_id: rand(0..5)
  )
end

10.times do |i|
  Task.create(
    name: "Task #{i}",
    hours: rand(0..8),
    deadline: Date.today + 7,
    user_id: 1,
    client_id: 1,
    task_category_id: rand(0..5),
    created_at: 1.weeks.ago,
    updated_at: 1.weeks.ago
  )
end
