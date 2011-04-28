class UserSession < Authlogic::Session::Base
  # workaround for mongomapper bug
  # http://bit.ly/bcQn3z
  def to_key
    [id.to_s]
  end
end

