# Delete me if you don't want an automatically created admin user

def setup_admin_user

  begin

    admin = User.first_or_create( :email => CONFIG.admin.email )
    admin.password = CONFIG.admin.pass
    admin.first_name = CONFIG.admin.first_name
    admin.last_name = CONFIG.admin.last_name
    admin.save!

    p 'Setting up Admin User'
    p admin

  rescue ArgumentError => detail

    p 'Your admin user details failed validation. Please see exceptions above, edit your config.yml and try again.'
    raise ArgumentError, detail.message

  end


end