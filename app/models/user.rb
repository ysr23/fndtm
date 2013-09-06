class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :tasks
  has_settings do |s|
    s.key :task, :defaults => { :new_task_entry => '1', :end_of_day => '1800',
                                :start_of_day => '800', :duration => '1'                             
     }
  end
  def update
    binding.pry
    @setting = User.settings(:task)
    current_user.settings(:task).(params[:option])
  end

end
