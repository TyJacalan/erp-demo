# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_620_053_431) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'admins', force: :cascade do |t|
    t.string 'full_name', default: '', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['invitation_token'], name: 'index_admins_on_invitation_token', unique: true
    t.index ['invited_by_id'], name: 'index_admins_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_admins_on_invited_by'
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_admins_on_unlock_token', unique: true
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'name'
    t.string 'abbreviation'
    t.text 'mission'
    t.string 'website'
    t.boolean 'nonprofit_status'
    t.integer 'status', default: 0, null: false
    t.text 'issue_areas', default: [], array: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contracts', force: :cascade do |t|
    t.bigint 'client_id', null: false
    t.float 'monthly_fee'
    t.date 'start_date'
    t.date 'end_date'
    t.integer 'service_type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['client_id'], name: 'index_contracts_on_client_id'
  end

  create_table 'memberships', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'memberable_type', null: false
    t.bigint 'memberable_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[memberable_type memberable_id], name: 'index_memberships_on_memberable'
    t.index ['user_id'], name: 'index_memberships_on_user_id'
  end

  create_table 'noticed_events', force: :cascade do |t|
    t.string 'type'
    t.string 'record_type'
    t.bigint 'record_id'
    t.jsonb 'params'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'notifications_count'
    t.index %w[record_type record_id], name: 'index_noticed_events_on_record'
  end

  create_table 'noticed_notifications', force: :cascade do |t|
    t.string 'type'
    t.bigint 'event_id', null: false
    t.string 'recipient_type', null: false
    t.bigint 'recipient_id', null: false
    t.datetime 'read_at', precision: nil
    t.datetime 'seen_at', precision: nil
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_noticed_notifications_on_event_id'
    t.index %w[recipient_type recipient_id], name: 'index_noticed_notifications_on_recipient'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'full_name', default: '', null: false
    t.string 'uid'
    t.string 'avatar_url'
    t.string 'provider'
    t.date 'birthdate'
    t.string 'mobile'
    t.string 'position'
    t.string 'team'
    t.float 'salary'
    t.boolean 'task_manager', default: false
    t.boolean 'client_manager', default: false
    t.boolean 'team_manager', default: false
    t.boolean 'moderator', default: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
    t.index ['invited_by_id'], name: 'index_users_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_users_on_invited_by'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'contracts', 'clients'
  add_foreign_key 'memberships', 'users'
end
