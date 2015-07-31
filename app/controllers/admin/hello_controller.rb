class Admin::HelloController < Admin::BaseController

  def index
    render text: "Congratulations!  You are an admin!"
  end
end
