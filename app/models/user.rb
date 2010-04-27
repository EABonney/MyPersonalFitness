class User < ActiveRecord::Base
  has_many :swim_workouts
  has_many :bike_workouts
  has_many :run_workouts
  has_many :other_workouts
  has_many :workouts
  has_many :routes
  has_many :race_reports
  has_many :races, :through => :race_reports
  
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
  end
  validates_length_of :first_name, {:on => :update, :maximum => 25, :message => "must not exceed 25 letters.", :if => :has_no_credentials?}
  validates_length_of :last_name, {:on => :update, :maximum => 25, :message => "must not exceed 25 letters.", :if => :has_no_credentials?}
  validates_length_of :street, {:on => :update, :maximum => 50, :message => "may not exceed 50 letters.", :if => :has_no_credentials?}
  validates_length_of :city, {:on => :update, :maximum => 25, :message => "may not exceed 25 letters.", :if => :has_no_credentials?}
  validates_length_of :state, {:on => :update, :is => 2, :message => "Please use the abbrivations for the State.", :if => :has_no_credentials?}
  validates_format_of :zipcode, {:on => :update, :with => /^\d{5}(-\d{4})?/, :if => :has_no_credentials?}
  
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name,
                  :street, :city, :state, :zipcode

  # we need to make sure that a password gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank?
  end

  def active?
    active
  end
  
  def activate!
    self.active = true
    save
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
  # now let's define a couple of methods in the user model. The first
  # will take care of setting any data that you want to happen at signup
  # (aka before activation)
  def signup!(params)
    self.username = params[:user][:username]
    self.email = params[:user][:email]
    save_without_session_maintenance
  end

  # the second will take care of setting any data that you want to happen
  # at activation. at the very least this will be setting active to true
  # and setting a pass.
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end

  def format_greeting
    if Time.now.hour < 12
      "Good morning "
    elsif Time.now.hour >= 12 && Time.now.hour < 17
      "Good afternoon "
    else
      "Good evening "
    end
  end
end
