# Delete me if you don't want an automatically created admin user

admin = User.first_or_create( :email => CONFIG.admin_email )
admin.password = CONFIG.admin_pass
admin.first_name = CONFIG.first_name
admin.last_name = CONFIG.last_name
admin.save!

p 'Setting up Admin User'
p admin