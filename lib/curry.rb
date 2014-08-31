class Proc
  remove_method :curry

  def curry
    proc do |*args|
      if args.length < arity
        proc { |*more_args| call(*args + more_args) }
      else
        call(*args)
      end
    end
  end
end
