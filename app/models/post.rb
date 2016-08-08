class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to(:user)

  has_attached_file(:avatar,
                    styles:        {medium: '400x400>',
                                    thumb:  '100x100>'},
                    default_url:   ':style/missing.png',
                    storage:       :s3
                    s3_credentials: Proc.new { |a| a.instance.s3_credentials })
                    )
  
  def s3_credentials
    {:bucket => "final-project-ruby",
    :access_key_id => "AKIAJ5FRIAY73Z3GKNFA",
    :secret_access_key => "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"}
  end

  validates_attachment_content_type(:avatar, content_type: /\Aimage\/.*\Z/)

  validates_presence_of(:text, message: 'can not be empty—please enter some text for your post')
  validates_length_of(:text, maximum: 140)

  def text_and_author
    "#{text} by #{user.email}"
  end
end
