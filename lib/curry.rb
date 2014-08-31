class Proc
  remove_method :curry

  def curry(arity = self.arity)
    proc do |*args|
      if args.length < arity
        proc { |*more_args| call(*args + more_args) }
      else
        call(*args)
      end
    end
  end
end
