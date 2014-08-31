class Proc
  remove_method :curry

  def curry
    proc do |*args|
      call(*args)
    end
  end
end
