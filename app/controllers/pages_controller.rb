class PagesController < ApplicationController
  def home
    render 'home'
  end

  def about
    render 'about'    
  end

  def testdrive
    render 'testdrive'    
  end

end
