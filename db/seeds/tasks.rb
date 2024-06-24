# frozen_string_literal: true

TaskCategory.insert_all(
  [
    {
      department: 0,
      name: 'Prospect Research'
    },
    {
      department: 3,
      name: 'Moves Action Plan'
    },
    {
      department: 1,
      name: 'Proposal V1'
    },
    {
      department: 1,
      name: 'Proposal V2'
    },
    {
      department: 2,
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
